import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
          LottieBuilder.asset("assets/lottie/popcorn.json"),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
                prefixIcon: Icon(CupertinoIcons.mail),
                label: Text("Email")),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Username",
                prefixIcon: Icon(CupertinoIcons.person),
                label: Text("Username")),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => TextField(
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
                  label: Text("password")),
            ),
          )
        ],
      ),
    ));
  }
}
