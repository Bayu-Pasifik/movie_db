import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/modules/home/controllers/upcoming_controller_controller.dart';

import 'app/modules/home/controllers/now_playing_controller_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.lazyPut(
    () => NowPlayingControllerController(),
  );
  Get.lazyPut(
    () => UpcomingControllerController(),
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
