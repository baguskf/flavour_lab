import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/video_tutorial_controller.dart';

class VideoTutorialView extends GetView<VideoTutorialController> {
  const VideoTutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () async {
            if (controller.isFullScreen.value) {
              controller.exitFullScreen();
              return false;
            }
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                if (!controller.isFullScreen.value) ...[
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                controller.exitFullScreen();
                                Get.back();
                              },
                              icon:
                                  const Icon(Icons.arrow_back_ios_new_outlined),
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Tutorial Video",
                                style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 45),
                        ],
                      ),
                    ),
                  ),
                ],
                Expanded(
                  child: YoutubePlayer(
                    controller: controller.player,
                    showVideoProgressIndicator: true,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
