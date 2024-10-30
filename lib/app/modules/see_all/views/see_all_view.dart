import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/see_all_controller.dart';

class SeeAllView extends GetView<SeeAllController> {
  const SeeAllView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: white,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        controller.categori,
                        style: const TextStyle(
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return MyWidget().shimmerSeeAll();
            }
            return Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 28, left: 28, right: 28),
                itemCount: controller.dataCategori.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.63,
                ),
                itemBuilder: (context, index) {
                  final data = controller.dataCategori[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 202,
                        width: 161,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            data.strMealThumb,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        data.strMeal,
                        style: const TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
