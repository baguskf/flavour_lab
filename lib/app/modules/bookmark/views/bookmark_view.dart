import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flavour_lab/app/routes/app_pages.dart';
import 'package:flavour_lab/app/widget/widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bookmark_controller.dart';

class Bookmarkview extends GetView<BookmarkController> {
  const Bookmarkview({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bookmark',
                  style: TextStyle(
                    fontFamily: 'myfont',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: controller.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var listData = snapshot.data!.docs;

                      if (listData.isEmpty) {
                        return const Center(
                          child: Text(
                            "Looks like you haven't saved anything yet. Add some bookmarks to see them here!",
                            style:
                                TextStyle(fontFamily: 'myfont', fontSize: 16),
                          ),
                        );
                      }
                      return Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.only(bottom: 50),
                          itemCount: listData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.61,
                          ),
                          itemBuilder: (context, index) {
                            final data =
                                listData[index].data() as Map<String, dynamic>;
                            return InkWell(
                              onTap: () => Get.toNamed(Routes.DETAIL,
                                  arguments: data['idMeal']),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 202,
                                    width: 161,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        "${(data['image'])}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Flexible(
                                    child: Text(
                                      "${(data['name_meal'])}",
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
                    }
                    return MyWidget().showLoadingWidget();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
