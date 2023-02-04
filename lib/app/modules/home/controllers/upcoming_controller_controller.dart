import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpcomingController extends GetxController {
  List upcomming = [];
  RefreshController upcommingRefresh = RefreshController(initialRefresh: true);
  var hal = 1.obs;
  var page;
  var totalPage;

  Future<List> getCurrent(int halaman) async {
    Uri url = Uri.parse('$comingSoon&page=$halaman');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'];
      page = json.decode(response.body)['page'];
      totalPage = json.decode(response.body)['total_pages'];
      var tempdata = data.map((e) => CurrentMovie.fromJson(e)).toList();
      upcomming.addAll(tempdata);
      print("page : $page");
      print("total : $totalPage");
    }
    return upcomming;
  }

  void refreshData() async {
    if (upcommingRefresh.initialRefresh == true) {
      hal.value = 1;
      upcomming = [];
      await getCurrent(hal.value);
      update();
      return upcommingRefresh.refreshCompleted();
    } else {
      return upcommingRefresh.refreshFailed();
    }
  }

  void loadData() async {
    if (page <= totalPage) {
      hal.value = hal.value + 1;
      await getCurrent(hal.value);
      update();
      return upcommingRefresh.loadComplete();
    } else {
      return upcommingRefresh.loadNoData();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
