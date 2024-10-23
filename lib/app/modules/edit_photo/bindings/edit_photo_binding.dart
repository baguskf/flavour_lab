import 'package:get/get.dart';

import '../controllers/edit_photo_controller.dart';

class EditPhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPhotoController>(
      () => EditPhotoController(),
    );
  }
}
