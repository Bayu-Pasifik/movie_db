import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NowPlayingController extends GetxController {
  var hal = 1.obs;
  RefreshController nowPlayingRefresh = RefreshController(initialRefresh: true);
  List<dynamic> current = [];
  var page;
  var totalPage;
  Future<List> getCurrent(int halaman) async {
    Uri url = Uri.parse('$nowPlaying&page=$halaman');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'];
      page = json.decode(response.body)['page'];
      totalPage = json.decode(response.body)['total_pages'];
      var tempdata = data.map((e) => CurrentMovie.fromJson(e)).toList();
      current.addAll(tempdata);
    }
    return current;
  }

  void refreshData() async {
    if (nowPlayingRefresh.initialRefresh == true) {
      hal.value = 1;
      current = [];
      await getCurrent(hal.value);
      update();
      return nowPlayingRefresh.refreshCompleted();
    } else {
      return nowPlayingRefresh.refreshFailed();
    }
  }

  void loadData() async {
    if (page <= totalPage) {
      hal.value = hal.value + 1;
      await getCurrent(hal.value);
      update();
      return nowPlayingRefresh.loadComplete();
    } else {
      return nowPlayingRefresh.loadNoData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // currentMovie = getCurrent();
  }

  @override
  void dispose() {
    super.dispose();

  }
}
