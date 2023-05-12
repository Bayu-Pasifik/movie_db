import 'package:get/get.dart';

import '../controllers/all_popular_movie_controller.dart';

class AllPopularMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPopularMovieController>(
      () => AllPopularMovieController(),
    );
  }
}
