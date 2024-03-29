import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllTopMovieController extends GetxController {
  List top = [];
  RefreshController topRefresh = RefreshController(initialRefresh: true);
  var hal = 1.obs;
  var page;
  var totalPage;

  Future<List> getCurrent(int halaman) async {
    Uri url = Uri.parse('$topRated&page=$halaman');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'];
      page = json.decode(response.body)['page'];
      totalPage = json.decode(response.body)['total_pages'];
      var tempdata = data.map((e) => CurrentMovie.fromJson(e)).toList();
      top.addAll(tempdata);
      print("page : $page");
      print("total : $totalPage");
    }
    return top;
  }

  void refreshData() async {
    if (topRefresh.initialRefresh == true) {
      hal.value = 1;
      // top = [];
      await getCurrent(hal.value);
      update();
      return topRefresh.refreshCompleted();
    } else {
      return topRefresh.refreshFailed();
    }
  }

  void loadData() async {
    if (page <= totalPage) {
      hal.value = hal.value + 1;
      await getCurrent(hal.value);
      update();
      return topRefresh.loadComplete();
    } else {
      return topRefresh.loadNoData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    topRefresh.dispose();
  }
}
