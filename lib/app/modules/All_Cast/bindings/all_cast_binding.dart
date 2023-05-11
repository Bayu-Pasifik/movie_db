import 'package:get/get.dart';

import '../controllers/all_cast_controller.dart';

class AllCastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllCastController>(
      () => AllCastController(),
    );
  }
}
