import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_db/app/modules/Login_Page/controllers/login_page_controller.dart';
import 'package:movie_db/app/routes/app_pages.dart';

import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  RegisterPageView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Container(
                  width: 150,
                  height: 150,
                  child: LottieBuilder.asset("assets/lottie/popcorn.json")),
              SizedBox(height: 20),
              Center(
                  child: Text(
                "Let\'s create account for you",
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
              )),
              SizedBox(height: 10),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailC,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          prefixIcon: Icon(CupertinoIcons.mail),
                          label: Text("Email", style: GoogleFonts.poppins())),
                      validator: (value) {
                        if (value == null) {
                          return "Please provide email";
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.usernameC,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Username",
                          prefixIcon: Icon(CupertinoIcons.person),
                          label:
                              Text("Username", style: GoogleFonts.poppins())),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide Username";
                        }

                        return null;
                      },
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
                          if (value == null || value.isEmpty) {
                            return "Please provide password";
                          }
                          if (value.length <= 6) {
                            return 'Password must be at least 6 characters';
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
                      controller.createAccount(
                        controller.emailC.text,
                        controller.usernameC.text,
                        controller.passwordC.text,
                      );
                    }
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
                    style:
                        GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.cleanText();
                        Get.toNamed(Routes.LOGIN_PAGE);
                      },
                      child: Text(
                        "Login here",
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
                  final authC = Get.find<LoginPageController>();
                  authC.loginWithGoogle();
                  controller.cleanText();
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
