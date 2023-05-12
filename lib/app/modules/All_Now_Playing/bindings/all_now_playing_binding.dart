import 'package:get/get.dart';

import '../controllers/all_now_playing_controller.dart';

class AllNowPlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllNowPlayingController>(
      () => AllNowPlayingController(),
    );
  }
}
