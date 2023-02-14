import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:movie_db/app/data/api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:convert';

import '../../../data/models/CurrentMovie.dart';

class TrendingPageController extends GetxController {
  var hal = 1.obs;
  RefreshController trendingRefresh = RefreshController(initialRefresh: true);
  List<dynamic> listTrending = [];
  late Future<List> trendingMovie;
  var page;
  var totalPage;
  Future<List> getTrending(String halaman) async {
    Uri url = Uri.parse('$trending&page=$halaman');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'];
      page = json.decode(response.body)['page'];
      totalPage = json.decode(response.body)['total_pages'];
      var tempdata = data.map((e) => CurrentMovie.fromJson(e)).toList();
      print(tempdata);
      listTrending.addAll(tempdata);
      print("page : $page");
      print("total : $totalPage");
    }
    return listTrending;
  }

  void refreshData() async {
    if (trendingRefresh.initialRefresh == true) {
      hal.value = 1;
      await getTrending(hal.value.toString());
      update();
      return trendingRefresh.refreshCompleted();
    } else {
      return trendingRefresh.refreshFailed();
    }
  }

  void loadData() async {
    if (page <= totalPage) {
      hal.value = hal.value + 1;
      await getTrending(hal.value.toString());
      update();
      return trendingRefresh.loadComplete();
    } else {
      return trendingRefresh.loadNoData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // trendingMovie = getTrending();
  }
}
