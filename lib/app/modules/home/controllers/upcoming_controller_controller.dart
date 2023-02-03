import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpcomingControllerController extends GetxController {
  List upcomming = [];
  late Future<List> upcommingMovie;
  RefreshController currentRefresh = RefreshController(initialRefresh: true);
  dynamic temp;
  Future<List> getCurrent() async {
    Uri url = Uri.parse('$comingSoon');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['items'];
      upcomming = data.map((e) => CurrentMovie.fromJson(e)).toList();
      print(upcomming);
    }
    return upcomming;
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
    upcommingMovie = getCurrent();
  }
}
