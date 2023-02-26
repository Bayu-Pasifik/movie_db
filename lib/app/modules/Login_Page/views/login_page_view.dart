import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_db/app/routes/app_pages.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
              width: 200,
              height: 200,
              child: LottieBuilder.asset("assets/lottie/popcorn.json")),
          TextField(
            controller: controller.emailC,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
                prefixIcon: Icon(CupertinoIcons.mail),
                label: Text("Email", style: GoogleFonts.poppins())),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => TextField(
              controller: controller.passwordC,
              obscureText: (controller.isHidden.isTrue) ? true : false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "password",
                  prefixIcon: Icon(CupertinoIcons.lock),
                  suffixIcon: IconButton(
                    icon: (controller.isHidden.isTrue)
                        ? Icon(CupertinoIcons.eye)
                        : Icon(CupertinoIcons.eye_slash),
                    onPressed: () {
                      controller.isHidden.value = !controller.isHidden.value;
                      print(controller.isHidden.value);
                    },
                  ),
                  label: Text("password", style: GoogleFonts.poppins())),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                controller.loginAccount(
                    controller.emailC.text, controller.passwordC.text);
              },
              child: Text(
                "Login",
                style: GoogleFonts.poppins(),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Not have account ?",
                style: GoogleFonts.poppins(),
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.REGISTER_PAGE);
                  },
                  child: Text(
                    "Register here",
                    style: GoogleFonts.poppins(),
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
