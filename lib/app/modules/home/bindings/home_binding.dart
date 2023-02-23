import 'package:get/get.dart';

import 'package:movie_db/app/modules/home/controllers/now_playing_controller_controller.dart';
import 'package:movie_db/app/modules/home/controllers/popular_controller.dart';
import 'package:movie_db/app/modules/home/controllers/top_controller.dart';
import 'package:movie_db/app/modules/home/controllers/upcoming_controller_controller.dart';
import 'package:movie_db/app/modules/watch_list/controllers/watch_list_controller.dart';
// import 'package:movie_db/app/modules/home/controllers/watch_list_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<WatchListController>(
    //   () => WatchListController(),
    // );
    Get.lazyPut<PopularController>(
      () => PopularController(),
    );
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
