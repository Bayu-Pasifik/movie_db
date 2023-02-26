import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/routes/app_pages.dart';

class LoginPageController extends GetxController {
  var isHidden = true.obs;
  final auth = FirebaseAuth.instance;
  late TextEditingController emailC;
  late TextEditingController passwordC;
  String userName = '';
  Stream<User?> get userStatus => auth.authStateChanges();
  // ! create account
  loginAccount(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(myUser.user);
      userName = myUser.user!.displayName!;
      print("Username : $userName");
      Get.offAllNamed(Routes.HOME, arguments: userName);
      // await myUser.user!.sendEmailVerification();
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
    passwordC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
  }
}
