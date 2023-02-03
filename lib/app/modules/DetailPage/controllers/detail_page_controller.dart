import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPageController extends GetxController {

  Future<DetailMovie> detailMovie(String id) async {
    Uri url = Uri.parse('$detail/$id');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var tempData = DetailMovie.fromJson(data);
    debugPrint(tempData.title);
    return tempData;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
