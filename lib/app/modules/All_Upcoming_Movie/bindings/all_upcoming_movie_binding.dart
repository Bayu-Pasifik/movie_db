import 'package:get/get.dart';

import '../controllers/all_upcoming_movie_controller.dart';

class AllUpcomingMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllUpcomingMovieController>(
      () => AllUpcomingMovieController(),
    );
  }
}
