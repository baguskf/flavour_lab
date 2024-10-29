import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_lab/app/controllers/firebase_service.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final auth = FirebaseService().auth;

  final TextEditingController passC = TextEditingController();
  final TextEditingController passNewC = TextEditingController();
  final TextEditingController confirmpassC = TextEditingController();

  var isPassValid = true.obs;
  var isNewPassValid = true.obs;
  var isCPassValid = true.obs;

  var isObscure = true.obs;
  var isNewObscure = true.obs;
  var isConfirmObscure = true.obs;

  var passwordError = RxnString();
  var passwordNewError = RxnString();
  var passwordConfirmError = RxnString();

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void toggleNewObscure() {
    isNewObscure.value = !isNewObscure.value;
  }

  void toggleConfirmObscure() {
    isConfirmObscure.value = !isConfirmObscure.value;
  }

  void validatePassword() {
    String pass = passC.text;
    if (pass.isEmpty) {
      passwordError.value = 'Current Password cannot be empty!';
      isPassValid.value = false;
    } else if (pass.length < 8) {
      passwordError.value = 'At least 8 characters!';
      isPassValid.value = false;
    } else {
      passwordError.value = null;
      isPassValid.value = true;
    }
  }

  void validateNewPassword() {
    String pass = passNewC.text;
    String currentpass = passC.text;
    if (pass.isEmpty) {
      passwordNewError.value = 'New password cannot be empty!';
      isNewPassValid.value = false;
    } else if (pass.length < 8) {
      passwordNewError.value = 'At least 8 characters!';
      isNewPassValid.value = false;
    } else if (currentpass == pass) {
      passwordNewError.value =
          'Your new password can’t be the same as the old one';
      isNewPassValid.value = false;
    } else {
      passwordNewError.value = null;
      isNewPassValid.value = true;
    }
  }

  void validatePasswordConfirmation() {
    String password = passNewC.text;
    String cpass = confirmpassC.text;
    if (cpass.isEmpty) {
      passwordConfirmError.value = 'Confirm Password cannot be empty!';
      isCPassValid.value = false;
    } else if (password != cpass) {
      passwordConfirmError.value = 'Passwords do not match!';
      isCPassValid.value = false;
    } else {
      passwordConfirmError.value = null;
      isCPassValid.value = true;
    }
  }

  ChangePasswordController() {
    passC.addListener(() {
      validatePassword();
      validateNewPassword();
    });
    passNewC.addListener(() {
      validateNewPassword();
      validatePasswordConfirmation();
    });

    confirmpassC.addListener(() {
      validatePasswordConfirmation();
    });
  }

  void forgotCurrentPass() {
    MyWidget().confirmationDialog(
      title: "Reset password",
      content: "Send a password reset link to ${auth.currentUser!.email}?",
      onConfirm: () {
        resetPassword(auth.currentUser!.email.toString());
      },
    );
  }

  void resetPassword(String email) async {
    MyWidget().showLoading();
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
      Get.back();
      MyWidget().snackReset();
    } on FirebaseAuthException catch (e) {
      Get.back();
      String errorMessage = MyWidget().getErrorMessage(e.code);
      Get.snackbar('Oops!', errorMessage);
    }
  }

  void validate() {
    if (!isPassValid.value ||
        !isNewPassValid.value ||
        !isCPassValid.value ||
        passC.text.isEmpty ||
        passNewC.text.isEmpty ||
        confirmpassC.text.isEmpty) {
      MyWidget().customDialog(
        title: "Oops!",
        isSuccess: false,
        isLoginDialog: true,
      );
    } else {
      MyWidget().confirmationDialog(
        title: "Confirm Changes",
        content: "Are you sure you want to change your password?",
        onConfirm: () {
          changePassword(passC.text, confirmpassC.text);
        },
      );
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    MyWidget().showLoading();

    try {
      User? user = auth.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);
      Get.back();
      Get.back();
      MyWidget().snackBar("Success", "Password updated successfully!");
    } catch (e) {
      Get.back();
      MyWidget().snackBar('Oops', 'Current password is incorrect');
    }
  }
}
