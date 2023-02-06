import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPageController extends GetxController {
  late Future<DetailMovie> detailfilm;
  Future<DetailMovie> detailMovie(String id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=$apikey&language=en-US');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var tempData = DetailMovie.fromJson(data);
    // debugPrint(tempData.title);
    return tempData;
  }

  @override
  void onReady() {
    super.onReady();
    final detailmov = Get.arguments as CurrentMovie;
    detailMovie(detailmov.id.toString());
  }

  @override
  void onInit() {
    final detailmov = Get.arguments as CurrentMovie;
    detailfilm = detailMovie(detailmov.id.toString());
    super.onInit();
  }
}
