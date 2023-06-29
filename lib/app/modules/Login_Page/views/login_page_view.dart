import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:email_validator/email_validator.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  LoginPageView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Container(
                  width: 150,
                  height: 150,
                  child: LottieBuilder.asset("assets/lottie/popcorn.json")),
              SizedBox(height: 30),
              Center(
                  child: Text(
                "Welcome back, you have been missed",
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              )),
              SizedBox(height: 10),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide email";
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
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
                      () => TextFormField(
                        controller: controller.passwordC,
                        obscureText:
                            (controller.isHidden.isTrue) ? true : false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "password",
                            prefixIcon: Icon(CupertinoIcons.lock),
                            suffixIcon: IconButton(
                              icon: (controller.isHidden.isTrue)
                                  ? Icon(CupertinoIcons.eye)
                                  : Icon(CupertinoIcons.eye_slash),
                              onPressed: () {
                                controller.isHidden.value =
                                    !controller.isHidden.value;
                              },
                            ),
                            label:
                                Text("password", style: GoogleFonts.poppins())),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please provide some password";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.loginAccount(
                        controller.emailC.text,
                        controller.passwordC.text,
                      );
                    }
                    controller.cleanText();
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
                    style:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.cleanText();
                        Get.toNamed(Routes.REGISTER_PAGE);
                      },
                      child: Text(
                        "Register here",
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 26, 164, 232),
                            fontSize: 16),
                      ))
                ],
              ),
              // ! divider continue with
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Or continue with',
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 16)),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  controller.loginWithGoogle();
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: LottieBuilder.asset(
                      "assets/lottie/google-logo.json",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
