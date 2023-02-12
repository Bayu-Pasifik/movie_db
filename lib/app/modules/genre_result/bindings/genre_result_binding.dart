import 'package:get/get.dart';

import '../controllers/genre_result_controller.dart';

class GenreResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreResultController>(
      () => GenreResultController(),
    );
  }
}
