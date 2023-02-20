import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/models/UserModel.dart';
import 'package:movie_db/app/routes/app_pages.dart';

class LoginPageController extends GetxController {
  var isHidden = true.obs;
  final _db = FirebaseFirestore.instance;

  // ! save to firebase

  createSave(UserModel userModel) {
    _db
        .collection("savedFilm")
        .add(userModel.toJason()) 
        .whenComplete(() => Get.snackbar(
            "Success", "Your data has been successfully stored",
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green[400]),
            )
        // ignore: body_might_complete_normally_catch_error
        .catchError((error, snackTree) {
      Get.snackbar(
        "Error",
        "Something went Wrong, please try again",
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
      );
      print(error.toString());
    });
  }
}
