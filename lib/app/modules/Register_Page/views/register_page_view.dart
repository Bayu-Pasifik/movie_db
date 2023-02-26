import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_db/app/data/models/UserModel.dart';
import 'package:movie_db/app/routes/app_pages.dart';

import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({Key? key}) : super(key: key);
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
          TextField(
            controller: controller.usernameC,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Username",
                prefixIcon: Icon(CupertinoIcons.person),
                label: Text("Username", style: GoogleFonts.poppins())),
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
                controller.createAccount(controller.emailC.text,
                    controller.usernameC.text, controller.passwordC.text);
              },
              child: Text(
                "Register",
                style: GoogleFonts.poppins(),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Have account ?",
                style: GoogleFonts.poppins(),
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN_PAGE);
                  },
                  child: Text(
                    "Login here",
                    style: GoogleFonts.poppins(),
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
