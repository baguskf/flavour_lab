import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/controllers/auth_controller.dart';
import 'package:flavour_lab/app/modules/profile/controllers/profile_controller.dart';
import 'package:flavour_lab/app/widget/widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authController = Get.put(AuthController(), permanent: true);
  final themeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authController.streamAuth,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: "FlavourLAB",
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute:
                snapshot.data != null ? Routes.BOTTOM_NAV : Routes.ONBOARDING,
            getPages: AppPages.routes,
          );
        }
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: MyWidget().showLoadingWidget(),
            ),
          ),
        );
      },
    );
  }
}
