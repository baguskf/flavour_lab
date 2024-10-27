import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            const SizedBox(
              height: 77,
            ),
            const Text(
              "Update Your Password to Keep Your Account Safe",
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
                controller: controller.passC,
                obscureText: controller.isObscure.value,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: grey,
                style: const TextStyle(
                  color: grey,
                  fontSize: 16,
                  fontFamily: 'myfont',
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: BorderRadius.all(
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
                  hintText: 'Current password',
                  hintStyle: const TextStyle(
                    color: grey,
                    fontFamily: 'myfont',
                    fontSize: 16,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                    child: SvgPicture.asset(
                      'assets/icons/password.svg',
                      height: 24,
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isObscure.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: grey,
                    ),
                    onPressed: () => controller.toggleObscure(),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  errorText: controller.passwordError.value,
                ),
                onChanged: (value) {
                  controller.validatePassword();
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(() => TextField(
                  obscureText: controller.isNewObscure.value,
                  controller: controller.passNewC,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: grey,
                  style: const TextStyle(
                    color: grey,
                    fontSize: 16,
                    fontFamily: 'myfont',
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                        borderRadius: BorderRadius.all(
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
                    hintText: 'New Password',
                    hintStyle: const TextStyle(
                      color: grey,
                      fontFamily: 'myfont',
                      fontSize: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isNewObscure.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: grey,
                      ),
                      onPressed: () => controller.toggleNewObscure(),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                      child: SvgPicture.asset(
                        'assets/icons/password.svg',
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    errorText: controller.passwordNewError.value,
                  ),
                  onChanged: (value) {
                    controller.validateNewPassword();
                  },
                )),
            const SizedBox(
              height: 15,
            ),
            Obx(() => TextField(
                  controller: controller.confirmpassC,
                  obscureText: controller.isConfirmObscure.value,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: grey,
                  style: const TextStyle(
                    color: grey,
                    fontSize: 16,
                    fontFamily: 'myfont',
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                        borderRadius: BorderRadius.all(
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
                    hintText: 'Confirm new Password',
                    hintStyle: const TextStyle(
                      color: grey,
                      fontFamily: 'myfont',
                      fontSize: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmObscure.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: grey,
                      ),
                      onPressed: () => controller.toggleConfirmObscure(),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                      child: SvgPicture.asset(
                        'assets/icons/password.svg',
                        height: 24,
                        width: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    errorText: controller.passwordConfirmError.value,
                  ),
                  onChanged: (value) {
                    controller.validatePasswordConfirmation();
                  },
                )),
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
                    backgroundColor: primary,
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
                    // controller.validateAndUpdate();
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
