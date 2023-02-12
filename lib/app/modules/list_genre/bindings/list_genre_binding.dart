import 'package:get/get.dart';

import '../controllers/list_genre_controller.dart';

class ListGenreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListGenreController>(
      () => ListGenreController(),
    );
  }
}
