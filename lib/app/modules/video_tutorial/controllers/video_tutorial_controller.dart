import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTutorialController extends GetxController {
  String linkyt = '';
  late YoutubePlayerController player;

  final isFullScreen = false.obs;

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    if (data is String) {
      linkyt = data;
    }
    String videoId = extractYoutubeId(linkyt);

    player = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );

    player.addListener(() {
      isFullScreen.value = player.value.isFullScreen;
    });
  }

  void exitFullScreen() {
    if (isFullScreen.value) {
      player.toggleFullScreenMode(); // Keluar dari fullscreen
      isFullScreen.value = false; // Set isFullScreen menjadi false
    }
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  String extractYoutubeId(String url) {
    final uri = Uri.parse(url);
    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v']!;
    } else if (uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.last;
    }
    return '';
  }
}
