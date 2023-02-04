import 'package:get/get.dart';

import 'package:movie_db/app/modules/home/controllers/now_playing_controller_controller.dart';
import 'package:movie_db/app/modules/home/controllers/top_controller_controller.dart';
import 'package:movie_db/app/modules/home/controllers/upcoming_controller_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopController>(
      () => TopController(),
    );
    Get.lazyPut<UpcomingController>(
      () => UpcomingController(),
    );
    Get.lazyPut<NowPlayingController>(
      () => NowPlayingController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
