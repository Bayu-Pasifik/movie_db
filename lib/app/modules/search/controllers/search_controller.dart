import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchController extends GetxController {
  RefreshController searchRefresh = RefreshController(initialRefresh: true);
  late TextEditingController searchController;
  List<dynamic> resultSearch = [];
  var page;
  var totalPage;
  var hal = 1.obs;
  Future<List> searchMovie(String query, String halaman) async {
    Uri url =
        Uri.parse('$searchMov&query=$query&page=$halaman&include_adult=false');
    var response = await http.get(url);
    var data = json.decode(response.body)["results"];
    page = json.decode(response.body)["page"];
    totalPage = json.decode(response.body)["total_pages"];
    var tempData = data.map((e) => CurrentMovie.fromJson(e)).toList();
    update();
    resultSearch.addAll(tempData);
    print("page : $page");
    print("total page : $totalPage");
    print(resultSearch.length.toString());
    update();
    return resultSearch;
  }

  void refreshData() async {
    if (searchRefresh.initialRefresh == true) {
      hal.value = 1;
      await searchMovie(searchController.text, hal.value.toString());
      update();
      return searchRefresh.refreshCompleted();
    } else {
      return searchRefresh.refreshFailed();
    }
  }

  void loadData() async {
    if (page <= totalPage) {
      hal.value = hal.value + 1;
      await searchMovie(searchController.text, hal.value.toString());
      update();
      return searchRefresh.loadComplete();
    } else {
      return searchRefresh.loadNoData();
    }
  }

  // ! detail
  Future<DetailMovie> detailMovie(String id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=$apikey&language=en-US');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var tempData = DetailMovie.fromJson(data);
    return tempData;
  }

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }

  @override
  void onClose() {
    searchController.clear();
    searchController.dispose();
    super.onClose();
  }
}
