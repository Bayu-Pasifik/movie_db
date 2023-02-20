import 'package:get/get.dart';

import '../controllers/detail_watch_list_controller.dart';

class DetailWatchListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWatchListController>(
      () => DetailWatchListController(),
    );
  }
}
