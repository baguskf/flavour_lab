import 'dart:io';

import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditPhotoController extends GetxController {
  var image = Rxn<File>();

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
                    clearImage();
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
