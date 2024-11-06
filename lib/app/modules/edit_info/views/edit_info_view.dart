import 'package:flavour_lab/app/colors/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/edit_info_controller.dart';

class EditInfoView extends GetView<EditInfoController> {
  const EditInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            const SizedBox(
              height: 77,
            ),
            const Text(
              "Let's Update Your Personal Information",
              style: TextStyle(
                fontFamily: 'myfont',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Obx(
              () => TextField(
                controller: controller.nameC,
                keyboardType: TextInputType.name,
                cursorColor: grey,
                maxLength: 20,
                buildCounter: (BuildContext context,
                    {int? currentLength,
                    required int? maxLength,
                    required bool isFocused}) {
                  return null;
                },
                style: const TextStyle(
                  color: grey,
                  fontSize: 16,
                  fontFamily: 'myfont',
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      )),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Name',
                  hintStyle: const TextStyle(
                    color: grey,
                    fontFamily: 'myfont',
                    fontSize: 16,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                    child: SvgPicture.asset(
                      'assets/icons/person.svg',
                      height: 24,
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  errorText: controller.nameError.value,
                ),
                onChanged: (value) {
                  controller.validateName();
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(() => TextField(
                  controller: controller.phoneC,
                  keyboardType: TextInputType.phone,
                  cursorColor: grey,
                  maxLength: 20,
                  buildCounter: (BuildContext context,
                      {int? currentLength,
                      required int? maxLength,
                      required bool isFocused}) {
                    return null;
                  },
                  style: const TextStyle(
                    color: grey,
                    fontSize: 16,
                    fontFamily: 'myfont',
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        )),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Phone',
                    hintStyle: const TextStyle(
                      color: grey,
                      fontFamily: 'myfont',
                      fontSize: 16,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                      child: SvgPicture.asset(
                        'assets/icons/phone.svg',
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    errorText: controller.phoneError.value,
                  ),
                  onChanged: (value) {
                    controller.validatephone();
                  },
                )),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: controller.dateC,
              keyboardType: TextInputType.datetime,
              cursorColor: grey,
              readOnly: true,
              maxLength: 20,
              onTap: () {
                controller.datepicker(context);
              },
              buildCounter: (BuildContext context,
                  {int? currentLength,
                  required int? maxLength,
                  required bool isFocused}) {
                return null;
              },
              style: const TextStyle(
                color: grey,
                fontSize: 16,
                fontFamily: 'myfont',
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    )),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Date of birth',
                hintStyle: const TextStyle(
                  color: grey,
                  fontFamily: 'myfont',
                  fontSize: 16,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                  child: SvgPicture.asset(
                    'assets/icons/ibirthday.svg',
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      height: 24,
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                    onPressed: () => controller.datepicker(context),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: green, width: 2),
                    ),
                    minimumSize: const Size(82, 43),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: 'myfont',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: green),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(82, 43),
                    backgroundColor: green,
                  ),
                  onPressed: () {
                    controller.validateAndUpdate();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        fontFamily: 'myfont',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
