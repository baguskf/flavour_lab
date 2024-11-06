import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/controllers/firebase_service.dart';
import 'package:flavour_lab/app/routes/app_pages.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: FirebaseService().streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllData = snapshot.data;
            var userData = listAllData?.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: SafeArea(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: 'myfont',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 124,
                            width: 124,
                            child: CircleAvatar(
                              backgroundColor: white,
                              child: ClipOval(
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                    'assets/images/loading_spinner.gif',
                                  ),
                                  image: userData["profile_picture"] != null &&
                                          userData["profile_picture"].isNotEmpty
                                      ? NetworkImage(
                                              userData["profile_picture"])
                                          as ImageProvider
                                      : const AssetImage(
                                          'assets/images/empty_profile.png'),
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/empty_profile.png',
                                        fit: BoxFit.cover);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () => Get.toNamed(Routes.EDIT_PHOTO),
                              child: CircleAvatar(
                                backgroundColor: green,
                                child: SvgPicture.asset(
                                  'assets/icons/edit.svg',
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${userData["name"]}",
                        style: const TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 20,
                          color: grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 52,
                    ),
                    const Text(
                      'Personal Infromation',
                      style: TextStyle(
                        fontFamily: 'myfont',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/email.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontFamily: 'myfont',
                                fontSize: 16,
                                color: grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.end,
                            "${userData["email"]}",
                            style: const TextStyle(
                              fontFamily: 'myfont',
                              fontSize: 16,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/phone.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Phone',
                              style: TextStyle(
                                fontFamily: 'myfont',
                                fontSize: 16,
                                color: grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.end,
                            "${userData["phone"] ?? "-"}",
                            style: const TextStyle(
                              fontFamily: 'myfont',
                              fontSize: 16,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/ibirthday.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Date of birth',
                              style: TextStyle(
                                fontFamily: 'myfont',
                                fontSize: 16,
                                color: grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.end,
                            "${userData["date"] ?? "-"}",
                            style: const TextStyle(
                              fontFamily: 'myfont',
                              fontSize: 16,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Setting',
                      style: TextStyle(
                        fontFamily: 'myfont',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.EDIT_INFO, arguments: [
                        userData["name"] ?? '-',
                        userData["phone"] ?? 'No phone number yet.',
                        userData["date"] ?? 'Tell us your birthday',
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/edit_info.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Edit Personal Infromation',
                                style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontSize: 16,
                                  color: grey,
                                ),
                              )
                            ],
                          ),
                          Flexible(
                              child: SvgPicture.asset('assets/icons/next.svg')),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/editpass.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Change Password',
                                style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontSize: 16,
                                  color: grey,
                                ),
                              )
                            ],
                          ),
                          SvgPicture.asset('assets/icons/next.svg'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/mode.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Theme light/dark',
                              style: TextStyle(
                                fontFamily: 'myfont',
                                fontSize: 16,
                                color: grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Obx(
                          () => FlutterSwitch(
                            width: 35.0,
                            activeColor: green,
                            height: 21.0,
                            toggleSize: 10.0,
                            value: controller.isDarkMode.value,
                            borderRadius: 30.0,
                            onToggle: (bool isDark) {
                              controller.toggleDarkMode(isDark);
                            },
                            padding: 5.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/about.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'About',
                              style: TextStyle(
                                fontFamily: 'myfont',
                                fontSize: 16,
                                color: grey,
                              ),
                            )
                          ],
                        ),
                        SvgPicture.asset('assets/icons/next.svg'),
                      ],
                    ),
                    const SizedBox(
                      height: 76,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(107, 43),
                            backgroundColor: green,
                          ),
                          onPressed: () => controller.logout(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset('assets/icons/signout.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Sign out',
                                style: TextStyle(
                                    fontFamily: 'myfont',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(child: MyWidget().showLoadingWidget());
        },
      ),
    );
  }
}
