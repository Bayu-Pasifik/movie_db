import 'package:get/get.dart';

import '../controllers/all_top_movie_controller.dart';

class AllTopMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllTopMovieController>(
      () => AllTopMovieController(),
    );
  }
}
