import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/controllers/firebase_service.dart';

import 'package:flavour_lab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shimmer/shimmer.dart';

class MyWidget {
  final auth = FirebaseService().auth;

  void showLoading() {
    Get.dialog(
      const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [Colors.green],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.transparent,
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget shimmerWidget() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 18),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: 202,
                    width: 152,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 152,
                    child: Container(
                      color: Colors.grey[300],
                      height: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget shimmerRecomen() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 18),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: 202,
                width: 255,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showLoadingWidget() {
    return const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [Colors.green],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  void snackBar(String title, String massage) {
    Get.snackbar(
      title,
      massage,
      snackPosition: SnackPosition.TOP,
      backgroundColor: green,
      colorText: white,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      borderRadius: 10,
    );
  }

  void snackReset() {
    Get.snackbar(
      'Password reset link sent!',
      'Please check your email for instructions to reset your password. Make sure to check your spam or junk folder if you don’t see it in your inbox.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: green,
      colorText: white,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      borderRadius: 10,
    );
  }

  void customDialog({
    required String title,
    required bool isSuccess,
    String? content,
    String? email,
    bool isLoginDialog = false,
  }) {
    if (Get.isDialogOpen!) {
      Get.back();
    }

    final String dialogContent = isSuccess
        ? (isLoginDialog
            ? "You’re in! Let’s get started."
            : 'Thanks for signing up with us! 🎉 To get started, we just need you to verify your email address $email')
        : content ??
            "Something went wrong. Please check your input and try again.";

    final String buttonContent =
        isSuccess ? (isLoginDialog ? "Let's go" : 'Change email') : "Oke";
    final String iconPath = isSuccess
        ? (isLoginDialog
            ? 'assets/images/success.png'
            : 'assets/images/email.png')
        : 'assets/images/error.png';

    final Color myColor = isSuccess ? Colors.green : Colors.red;

    Get.dialog(
      AlertDialog(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Column(
          children: [
            Image.asset(
              iconPath,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 25),
            Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(
                fontSize: 30,
                color: myColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'myfont',
              ),
            ),
            const SizedBox(height: 15),
            Text(
              dialogContent,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'myfont',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (!isLoginDialog && auth.currentUser != null) {
                showLoading();
                await FirebaseService().deleteUser();
                Get.back();
              } else if (isLoginDialog && isSuccess) {
                Get.offAllNamed(Routes.BOTTOM_NAV);
              }
              Get.back();
            },
            child: Text(
              buttonContent,
              style: TextStyle(color: myColor, fontFamily: 'myfont'),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void confirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    if (Get.isDialogOpen!) {
      Get.back();
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
            color: green,
            fontWeight: FontWeight.bold,
            fontFamily: 'myfont',
          ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'myfont',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  String getErrorMessage(String errorCode) {
    final errorMessages = {
      'invalid-credential': 'Incorrect email or password.',
      'channel-error': 'Please fill in all the details!',
      'wrong-password': 'Oops, wrong password.',
      'invalid-email': 'Invalid email address.',
      'weak-password': 'Your password is too weak.',
      'email-already-in-use': 'This email is already in use.',
      'The email address is badly formatted': 'The email format looks off.'
    };
    return errorMessages[errorCode] ?? 'Something went wrong: $errorCode';
  }
}
