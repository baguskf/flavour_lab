// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_lab/app/colors/colors.dart';

import 'package:flavour_lab/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

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
              await auth.currentUser!.delete();
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
            onConfirm();
            Get.back();
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
