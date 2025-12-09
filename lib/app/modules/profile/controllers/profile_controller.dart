import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/controllers/firebase_service.dart';
import 'package:flavour_lab/app/controllers/theme_service.dart';
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

  final themeService = ThemeService();

  @override
  void onInit() {
    loadThemeMode();
    super.onInit();
  }

  void toggleDarkMode(bool isDark) async {
    isDarkMode.value = isDark;
    await themeService.saveThemeMode(isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> loadThemeMode() async {
    bool isDark = await themeService.getThemeMode();
    isDarkMode.value = isDark;
    if (isDark) {
      Get.changeTheme(darkTheme);
    } else {
      Get.changeTheme(lightTheme);
    }
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
