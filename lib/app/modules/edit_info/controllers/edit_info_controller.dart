// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditInfoController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore data = FirebaseFirestore.instance;

  var isNameValid = true.obs;
  var isPhoneValid = true.obs;

  var nameError = RxnString();
  var phoneError = RxnString();

  String initialName = '';
  String initialPhone = '';
  String initialDate = '';

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController dateC = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    var arguments = Get.arguments;
    if (arguments != null && arguments.length >= 3) {
      initialName = arguments[0];
      initialPhone = arguments[1];
      initialDate = arguments[2];

      nameC.text = initialName;
      phoneC.text = initialPhone;
      dateC.text = initialDate;
    }
  }

  void validateName() {
    String name = nameC.text;
    if (name.isEmpty) {
      nameError.value = 'Name cannot be empty!';
      isPhoneValid.value = false;
    } else if (name.length < 2 || name.length > 30) {
      nameError.value = 'Name must be between 2 and 30 characters!';
      isPhoneValid.value = false;
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      nameError.value = 'Name can only contain letters and spaces!';
      isPhoneValid.value = false;
    } else {
      nameError.value = null;
      isPhoneValid.value = true;
    }
  }

  void validatephone() {
    String phone = phoneC.text;

    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      phoneError.value = 'Phone must contain only numbers!';
      isPhoneValid.value = false;
    } else if (phone.length < 10 || phone.length > 13) {
      phoneError.value = 'Phone must be between 10 and 13 numbers!';
      isPhoneValid.value = false;
    } else {
      phoneError.value = null;
      isPhoneValid.value = true;
    }
  }

  void validateAndUpdate() {
    bool isChanged = nameC.text != initialName ||
        phoneC.text != initialPhone ||
        dateC.text != initialDate;

    if (!isChanged) {
      Get.snackbar(
        "Hey!",
        "Looks like nothing's changed!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: green,
        colorText: white,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        borderRadius: 10,
      );
      return;
    }

    if (isNameValid.value && isPhoneValid.value) {
      MyWidget().confirmationDialog(
        title: "Confirm Changes",
        content: "Are you sure you want to update your information?",
        onConfirm: () {
          updateData(nameC.text, phoneC.text, dateC.text);
        },
      );
    } else {
      MyWidget().customDialog(
        title: "Oops!",
        isSuccess: false,
        isLoginDialog: true,
      );
    }
  }

  void updateData(String name, String phone, String date) async {
    MyWidget().showLoading();
    try {
      await data.collection('users').doc(auth.currentUser!.uid).update({
        'name': name,
        'phone': phone,
        'date': date,
      });
      Get.back();
      Get.back();
      MyWidget().snackBar("Success", "Data updated successfully!");
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  void updateDate(DateTime newDate) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    dateC.text = formatter.format(newDate);
  }

  void datepicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: green,
              onPrimary: white,
              onSurface: Colors.black,
            ),
            datePickerTheme: DatePickerThemeData(
              dividerColor: green,
              backgroundColor: Colors.white,
              headerBackgroundColor: green,
              headerForegroundColor: Colors.white,
              dayForegroundColor: MaterialStateProperty.all(Colors.black),
            ),
          ),
          child: child!,
        );
      },
    ).then((selectedDate) {
      if (selectedDate != null) {
        updateDate(selectedDate);
      }
    });
  }
}
