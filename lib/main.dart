import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/modules/Login_Page/controllers/login_page_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginPageController>(
      init: LoginPageController(),
      builder: (c) {
        return StreamBuilder<User?>(
            stream: c.userStatus,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

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
