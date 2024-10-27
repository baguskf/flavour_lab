import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
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
    if (pass.isEmpty) {
      passwordNewError.value = 'New password cannot be empty!';
      isNewPassValid.value = false;
    } else if (pass.length < 8) {
      passwordNewError.value = 'At least 8 characters!';
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
    });
    passNewC.addListener(() {
      validateNewPassword();
      validatePasswordConfirmation();
    });

    confirmpassC.addListener(() {
      validatePasswordConfirmation();
    });
  }
}
