import 'package:get/get.dart';

import '../controllers/bookmark_view.dart';

class BookmarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkController>(
      () => BookmarkController(),
    );
  }
}
