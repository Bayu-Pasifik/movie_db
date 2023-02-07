import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_db/app/data/models/ReviewMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailPageController extends GetxController {
  late Future<DetailMovie> detailfilm;
  List<dynamic> reviews = [];
  RefreshController reviewRefresh = RefreshController(initialRefresh: true);
  var page;
  var totalPage;
  var hal = 1.obs;
  Future<DetailMovie> detailMovie(String id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=$apikey&language=en-US');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var tempData = DetailMovie.fromJson(data);
    // debugPrint(tempData.title);
    return tempData;
  }

  Future<List> reviewMovie(String id, int hal) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/reviews?api_key=b29f6442d152f9b427bd2184b3d3c707&language=en-US&page=$hal');
    var response = await http.get(url);
    var data = json.decode(response.body)['results'];
    page = json.decode(response.body)['page'];
    totalPage = json.decode(response.body)['total_pages'];
    var tempData = data.map((e) => ReviewMovie.fromJson(e)).toList();
    reviews.addAll(tempData);
    return reviews;
  }

  void refreshData(String id) async {
    if (reviewRefresh.initialRefresh == true) {
      hal.value = 1;
      await reviewMovie(id, hal.value);
      update();
      return reviewRefresh.refreshCompleted();
    } else {
      return reviewRefresh.refreshFailed();
    }
  }

  void loadData(String id) async {
    if (page <= totalPage) {
      hal.value = hal.value + 1;
      await reviewMovie(id, hal.value);
      update();
      return reviewRefresh.loadComplete();
    } else {
      return reviewRefresh.loadNoData();
    }
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
