import 'package:flavour_lab/app/controllers/firebase_service.dart';
import 'package:flavour_lab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  final auth = FirebaseService().auth;
  final data = FirebaseService().data;

  final TextEditingController emailC = TextEditingController();
  final TextEditingController dateC = TextEditingController();

  var isDarkMode = false.obs;

  var userProfile = {}.obs;

  void toggleDarkMode(bool isDark) {
    isDarkMode.value = isDark;

    if (isDark) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
