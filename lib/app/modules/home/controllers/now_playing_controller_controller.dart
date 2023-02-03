import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NowPlayingControllerController extends GetxController {
  List current = [];
  late Future<List> currentMovie;
  RefreshController currentRefresh = RefreshController(initialRefresh: true);
  dynamic temp;
  Future<List> getCurrent() async {
    Uri url = Uri.parse('$nowPlaying');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['items'];
      current = data.map((e) => CurrentMovie.fromJson(e)).toList();
      print(current);
    }
    return current;
  }

  void refreshData() async {
    if (currentRefresh.initialRefresh == true) {
      await getCurrent();
      update();
      return currentRefresh.refreshCompleted();
    } else {
      return currentRefresh.refreshFailed();
    }
  }

  @override
  void onInit() {
    super.onInit();
    currentMovie = getCurrent();
  }
}
