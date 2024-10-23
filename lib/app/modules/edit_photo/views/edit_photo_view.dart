import 'package:flavour_lab/app/colors/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/edit_photo_controller.dart';

class EditPhotoView extends GetView<EditPhotoController> {
  const EditPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: const Text('Profile photo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => controller.showImagePicker(),
              child: SvgPicture.asset(
                'assets/icons/edit.svg',
                color: Colors.black,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => controller.image.value == null
                ? const Text('No image selected.')
                : Image.file(controller.image.value!)),
            // ElevatedButton(
            //     onPressed: () => controller.cropImage(), child: Text('Crop'))
          ],
        ),
      ),
    );
  }
}
