import 'package:flavour_lab/app/colors/colors.dart';
import 'package:flavour_lab/app/routes/app_pages.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return MyWidget().showLoadingWidget();
        }
        final data = controller.dataDetail.value;
        return Stack(
          children: [
            Image.network(
              data.strMealThumb,
              height: 412,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 50,
              left: 28,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 28,
              child: Obx(() => InkWell(
                    onTap: () => controller.togglesSave(),
                    child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        child: controller.isSaved.value
                            ? SvgPicture.asset('assets/icons/saved.svg')
                            : SvgPicture.asset(
                                'assets/icons/addBookmark.svg',
                                color: Theme.of(context).colorScheme.background,
                              )),
                  )),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.56,
              minChildSize: 0.56,
              maxChildSize: 0.88,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/icons/drag.svg',
                            ),
                          ),
                        ),
                        const SizedBox(height: 17),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.strMeal,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'myfont',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data.strArea,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'myfont',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Instructions',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Obx(() {
                                  final instructions =
                                      controller.getDisplayedInstructions();

                                  final instructionLines =
                                      instructions.split('\n');

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: instructionLines.map((line) {
                                      return line.isNotEmpty
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    '${instructionLines.indexOf(line) + 1}. ',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'myfont',
                                                      color: grey,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    textAlign:
                                                        TextAlign.justify,
                                                    line,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'myfont',
                                                      color: grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox();
                                    }).toList(),
                                  );
                                }),
                                if (data.strInstructions.split('\n').length > 5)
                                  GestureDetector(
                                    onTap: () {
                                      controller.toggleExpanded();
                                    },
                                    child: Obx(() {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Text(
                                          controller.getSeeMoreText(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'myfont',
                                            color: green,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Ingredients',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                    data.ingredients.length,
                                    (index) {
                                      final ingredient =
                                          data.ingredients[index];
                                      final measure = data.measures[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 47,
                                              width: 47,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Center(
                                                child: Obx(
                                                  () {
                                                    if (controller
                                                            .ingredientImages
                                                            .isNotEmpty &&
                                                        controller
                                                                .ingredientImages
                                                                .length >
                                                            index) {
                                                      return Container(
                                                        height: 47,
                                                        width: 47,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: grey2,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Image.network(
                                                            controller
                                                                    .ingredientImages[
                                                                index],
                                                            fit: BoxFit.contain,
                                                            loadingBuilder:
                                                                (context, child,
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              }
                                                              return Center(
                                                                child: MyWidget()
                                                                    .showLoadingWidget(),
                                                              );
                                                            },
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return const SizedBox(
                                                                height: 50,
                                                                child: Text(
                                                                    "Image not available"),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return const SizedBox(
                                                        height: 50,
                                                        child: Text(
                                                            "Image not available"),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                ingredient,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                measure,
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(158, 39),
                    backgroundColor: green,
                  ),
                  onPressed: () => Get.toNamed(
                    Routes.VIDEO_TUTORIAL,
                    arguments: data.strYoutube,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/icons/playtutor.svg'),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Tutorial video',
                        style: TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 12,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
