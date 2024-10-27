import 'package:flavour_lab/app/modules/home/controllers/home_controller.dart';
import 'package:flavour_lab/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/bottomnav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomnavController>(
      () => BottomnavController(),
    );

    Get.put<ProfileController>(
      ProfileController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
