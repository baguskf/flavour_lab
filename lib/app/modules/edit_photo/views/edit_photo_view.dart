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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Profile photo',
                        style: TextStyle(
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.showImagePicker(),
                    child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        child: SvgPicture.asset(
                          'assets/icons/edit.svg',
                          color: Theme.of(context).colorScheme.background,
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Obx(
            () {
              if (controller.image.value != null) {
                return Image.file(controller.image.value!);
              }
              if (controller.currentImage.value.isNotEmpty) {
                return Image.network(controller.currentImage.value);
              } else {
                return Image.asset('assets/images/empty_profile.png');
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
