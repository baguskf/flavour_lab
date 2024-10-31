import 'package:get/get.dart';

import '../controllers/video_tutorial_controller.dart';

class VideoTutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoTutorialController>(
      () => VideoTutorialController(),
    );
  }
}
