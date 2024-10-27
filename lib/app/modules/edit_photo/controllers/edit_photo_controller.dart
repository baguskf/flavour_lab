import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/controllers/firebase_service.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditPhotoController extends GetxController {
  final auth = FirebaseService().auth;
  final data = FirebaseService().data;
  final storage = FirebaseService().storage;

  var image = Rxn<File>();
  var currentImage = ''.obs;

  @override
  void onInit() {
    fetchImage();
    super.onInit();
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      await cropImage(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<void> uploadImage() async {
    if (image.value != null) {
      try {
        MyWidget().showLoading();

        String fileName = 'profile_pictures_${auth.currentUser!.email}.jpg';
        print('Uploading image: ${image.value!.path}');
        UploadTask uploadTask = storage.ref(fileName).putFile(image.value!);
        TaskSnapshot snapshot = await uploadTask;

        String downloadUrl = await snapshot.ref.getDownloadURL();

        print('Download URL: $downloadUrl');

        await data.collection('users').doc(auth.currentUser!.uid).update({
          'profile_picture': downloadUrl,
        });

        print('Image uploaded and URL saved to Firestore!');

        Get.back();
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image selected');
    }
  }

  void fetchImage() async {
    try {
      DocumentSnapshot userDoc =
          await data.collection('users').doc(auth.currentUser!.uid).get();

      if (userDoc.exists && userDoc['profile_picture'] != null) {
        String profilePictureUrl = userDoc['profile_picture'];

        currentImage.value = profilePictureUrl;
      } else {
        print('No profile picture found.');
      }
    } catch (e) {
      print('Error deleting profile picture: $e');
    }
  }

  void deleteProfilePicture() async {
    try {
      DocumentSnapshot userDoc =
          await data.collection('users').doc(auth.currentUser!.uid).get();

      if (userDoc.exists && userDoc['profile_picture'] != null) {
        String profilePictureUrl = userDoc['profile_picture'];

        Reference storageRef =
            FirebaseStorage.instance.refFromURL(profilePictureUrl);

        await storageRef.delete();
        print('Profile picture deleted from storage.');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .update({'profile_picture': FieldValue.delete()});

        print('Profile picture URL deleted from Firestore.');
      } else {
        print('No profile picture found.');
      }
    } catch (e) {
      print('Error deleting profile picture: $e');
    }
  }

  Future<void> cropImage(String imagePath) async {
    if (image.value != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.value!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Profile photo',
            toolbarColor: green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            statusBarColor: green,
            activeControlsWidgetColor: green,
            lockAspectRatio: true,
            hideBottomControls: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );
      if (croppedFile != null) {
        image.value = File(croppedFile.path);
        uploadImage();
      } else {
        image.value = null;
      }
    }
  }

  void clearImage() {
    image.value = null;
  }

  void showImagePicker() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                const Text(
                  'Profile Photo',
                  style: TextStyle(
                    color: green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: green),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
            const Divider(color: green),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Get.back();
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/camera.svg',
                        height: 40,
                        width: 40,
                        color: green,
                      ),
                      const SizedBox(height: 8),
                      const Text('Camera', style: TextStyle(color: green)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Get.back();
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/gallery.svg',
                        height: 40,
                        width: 40,
                        color: green,
                      ),
                      const SizedBox(height: 8),
                      const Text('Gallery', style: TextStyle(color: green)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    deleteProfilePicture();
                    Get.back();
                    Get.back();
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/delete.svg',
                        height: 40,
                        width: 40,
                        color: green,
                      ),
                      const SizedBox(height: 8),
                      const Text('Remove', style: TextStyle(color: green)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
