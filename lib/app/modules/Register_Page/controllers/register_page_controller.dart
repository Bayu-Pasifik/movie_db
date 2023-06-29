import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPageController extends GetxController {
  var isHidden = true.obs;
  final auth = FirebaseAuth.instance;
  late TextEditingController emailC;
  late TextEditingController usernameC;
  late TextEditingController passwordC;

  Stream<User?> get userStatus => auth.authStateChanges();
  // ! create account
  createAccount(String email, String username, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(myUser.user);
      await myUser.user!.sendEmailVerification();
      myUser.user!.updateDisplayName(username);
      Get.defaultDialog(
          title: "Register Successfully",
          middleText:
              "Your account has been registered successfully please check your email for verication code",
          onConfirm: () {
            Get.back(); // Close dialog
            Get.back();
          },
          middleTextStyle: GoogleFonts.poppins(color: Colors.white),
          textConfirm: "Yes i'am understand");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == "email-already-in-use") {
        var codeError = e.code.replaceAll("-", " ");
        Get.defaultDialog(
            title: "Error",
            middleText: "$codeError plese use another email",
            middleTextStyle: GoogleFonts.poppins(),
            onConfirm: () {
              Get.back(); // Close dialog
            },
            textConfirm: "Yes i'am understand");
      }
      if (e.code == "invalid-email") {
        var codeError = e.code.replaceAll("-", " ");
        Get.defaultDialog(
            title: "Error",
            middleText: "$codeError plese use another email",
            middleTextStyle: GoogleFonts.poppins(),
            onConfirm: () {
              Get.back(); // Close dialog
            },
            textConfirm: "Yes i'am understand");
      }
      if (e.code == "weak-password") {
        var codeError = e.code.replaceAll("-", " ");
        Get.defaultDialog(
            title: "Error",
            middleText: "$codeError plese create stronger password",
            middleTextStyle: GoogleFonts.poppins(),
            onConfirm: () {
              Get.back(); // Close dialog
            },
            textConfirm: "Yes i'am understand");
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    usernameC = TextEditingController();
    passwordC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    usernameC.dispose();
    passwordC.dispose();
  }

  void cleanText() {
    emailC.clear();
    passwordC.clear();
    usernameC.clear();
  }
}
