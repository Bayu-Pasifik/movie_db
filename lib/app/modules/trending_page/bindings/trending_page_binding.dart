import 'package:get/get.dart';

import '../controllers/trending_page_controller.dart';

class TrendingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrendingPageController>(
      () => TrendingPageController(),
    );
  }
}
