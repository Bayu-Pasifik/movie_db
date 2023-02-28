import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/modules/Login_Page/controllers/login_page_controller.dart';
import 'package:movie_db/app/modules/Login_Page/views/login_page_view.dart';
import 'package:movie_db/app/modules/home/controllers/upcoming_controller_controller.dart';
import 'package:movie_db/app/modules/home/views/home_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app/modules/home/controllers/now_playing_controller_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final authC = Get.put(LoginPageController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginPageController>(
      init: LoginPageController(),
      builder: (c) {
        return StreamBuilder<User?>(
            stream: c.userStatus,
            builder: (context, snapshot) {
              print("isi snapshot main stream sebelum if : ${snapshot.data}");
              print(
                  "display name main stream sebelum if: ${snapshot.data?.displayName}");

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              print("isi snapshot main stream sesudah if : ${snapshot.data}");
              print(
                  "display name main stream sesudah if: ${snapshot.data?.displayName}");
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Application",
                initialRoute: ((snapshot.data != null) &&
                        (snapshot.data!.emailVerified == true)
                    ? Routes.HOME
                    : Routes.LOGIN_PAGE),
                getPages: AppPages.routes,
              );
            });
      },
    );
  }
}
