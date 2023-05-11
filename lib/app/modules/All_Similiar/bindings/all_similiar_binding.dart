import 'package:get/get.dart';

import '../controllers/all_similiar_controller.dart';

class AllSimiliarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllSimiliarController>(
      () => AllSimiliarController(),
    );
  }
}
