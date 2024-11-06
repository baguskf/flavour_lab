import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/routes/app_pages.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.searchC,
                        cursorColor: grey,
                        autofocus: true,
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Looking for a recipe',
                          hintStyle: const TextStyle(
                            color: grey,
                            fontFamily: 'myfont',
                            fontSize: 16,
                          ),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 9.0),
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
                        onSubmitted: (value) =>
                            controller.searchRecipe(controller.searchC.text),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return MyWidget().shimmerSeeAll();
              }
              return Expanded(
                child: GridView.builder(
                  padding:
                      const EdgeInsets.only(bottom: 28, left: 28, right: 28),
                  itemCount: controller.dataCategori.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.61,
                  ),
                  itemBuilder: (context, index) {
                    final data = controller.dataCategori[index];
                    return InkWell(
                      onTap: () =>
                          Get.toNamed(Routes.DETAIL, arguments: data.idMeal),
                      child: Column(
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
                          Flexible(
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
                        ],
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ));
  }
}
