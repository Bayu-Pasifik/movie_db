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
  Stream<User?> get userStatus => auth.authStateChanges();
  final currentUser = FirebaseAuth.instance.currentUser;
  // ! Login account
  void loginAccount(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(myUser.user);
      if (myUser.user!.emailVerified) {
        print(currentUser);
        var userName = myUser.user!.displayName!;
        print("Username form login controller : $userName");
        Get.offAllNamed(Routes.HOME,
            arguments: currentUser?.displayName ?? "null");
      } else {
        Get.defaultDialog(
            title: "Error",
            middleText:
                " pleseverif your email\n not recive verification code?",
            middleTextStyle: GoogleFonts.poppins(),
            textCancel: "Cancle",
            onCancel: () => Get.back(),
            onConfirm: () async {
              await myUser.user!.sendEmailVerification();
            },
            textConfirm: "Yes i'am understand");
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
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
      if (e.code == "user-not-found") {
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
      if (e.code == "wrong-password") {
        var codeError = e.code.replaceAll("-", " ");
        Get.defaultDialog(
            title: "Error",
            middleText: "$codeError plese input the right password",
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
    emailC.clear();
    passwordC.clear();
  }
}
