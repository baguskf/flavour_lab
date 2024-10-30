import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/controllers/firebase_service.dart';
import 'package:flavour_lab/app/routes/app_pages.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: FirebaseService().streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllData = snapshot.data;
            var userData = listAllData?.data() as Map<String, dynamic>;
            return Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 28, right: 28),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi, ${userData["name"]}',
                                    style: const TextStyle(
                                      fontFamily: 'myfont',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: grey,
                                    ),
                                  ),
                                  const Text(
                                    'What do you want to cook today?',
                                    style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: InkWell(
                                onTap: () => Get.toNamed(Routes.EDIT_PHOTO),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  child: ClipOval(
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                        'assets/images/loading_spinner.gif',
                                      ),
                                      image: userData["profile_picture"] !=
                                                  null &&
                                              userData["profile_picture"]
                                                  .isNotEmpty
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
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: TextField(
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
                          fillColor: Colors.white,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: white),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: white),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          hintText: 'Looking for a recipe',
                          hintStyle: const TextStyle(
                            color: grey,
                            fontFamily: 'myfont',
                            fontSize: 16,
                          ),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(left: 9.0, right: 9.0),
                            child: SvgPicture.asset(
                              'assets/icons/search.svg',
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 27.0),
                          child: Text(
                            'Categori',
                            style: TextStyle(
                              fontFamily: 'myfont',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              children: controller.categories.map((category) {
                                return Obx(() {
                                  bool isSelected =
                                      controller.selectedCategory.value ==
                                          category["name"];
                                  return GestureDetector(
                                    onTap: () {
                                      controller.setSelectedCategory(
                                          category["name"]);
                                    },
                                    child: Container(
                                      height: 62,
                                      width: 71,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.green
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: isSelected
                                                ? Colors.green
                                                : Colors.white),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            category["icon"],
                                            width: 45,
                                            height: 35,
                                          ),
                                          Text(
                                            category["name"],
                                            style: TextStyle(
                                              fontFamily: 'myfont',
                                              fontSize: 12,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recipe',
                                style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.toNamed(Routes.SEE_ALL,
                                    arguments:
                                        controller.selectedCategory.value),
                                child: const Text(
                                  'See All',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return MyWidget().shimmerWidget();
                          }
                          return SizedBox(
                            height: 260,
                            width: double.infinity,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 18),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  min(10, controller.dataCategori.length),
                              itemBuilder: (context, index) {
                                final data = controller.dataCategori[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: SizedBox(
                                        height: 202,
                                        width: 152,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            data.strMealThumb,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: SizedBox(
                                        width: 152,
                                        child: Text(
                                          data.strMeal,
                                          style: const TextStyle(
                                            fontFamily: 'myfont',
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 5,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.0),
                          child: Text(
                            'Maybe You Like',
                            style: TextStyle(
                              fontFamily: 'myfont',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Obx(
                          () {
                            if (controller.isLoadingRecomen.value) {
                              return MyWidget().shimmerRecomen();
                            }
                            return SizedBox(
                              height: 202,
                              width: double.infinity,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(left: 18),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    min(10, controller.dataRecomen.length),
                                itemBuilder: (context, index) {
                                  final data = controller.dataRecomen[index];
                                  return InkWell(
                                    // onTap: () => Get.toNamed(Routes.SEE_ALL,
                                    //     arguments:
                                    //         controller.selectedCategory.value),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: SizedBox(
                                            height: 202,
                                            width: 255,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                data.strMealThumb,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                bottom: Radius.circular(15.0),
                                              ),
                                              child: Container(
                                                height: 202,
                                                width: 255,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(1),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          left: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: SizedBox(
                                              width: 200,
                                              child: Text(
                                                data.strMeal,
                                                style: const TextStyle(
                                                  fontFamily: 'myfont',
                                                  fontSize: 16,
                                                  color: white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 90,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return Center(child: MyWidget().showLoadingWidget());
        },
      ),
    );
  }
}
