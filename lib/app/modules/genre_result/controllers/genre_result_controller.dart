import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GenreResultController extends GetxController {
  var hal = 1.obs;
  RefreshController currentRefresh = RefreshController(initialRefresh: true);
  List<dynamic> current = [];
  var page;
  var totalPage;
  Future<List> getCurrent(String id, int halaman) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=$apikey&language=en-US&sort_by=popularity.asc&include_adult=false&include_video=false&page=$halaman&with_genres=$id&with_watch_monetization_types=flatrate');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'];
      page = json.decode(response.body)['page'];
      totalPage = json.decode(response.body)['total_pages'];
      var tempdata = data.map((e) => CurrentMovie.fromJson(e)).toList();
      current.addAll(tempdata);
      print("page : $page");
      print("total : $totalPage");
    }
    return current;
  }

  void refreshData(String idGenre) async {
    if (currentRefresh.initialRefresh == true) {
      hal.value = 1;
      current = [];
      await getCurrent(idGenre, hal.value);
      update();
      return currentRefresh.refreshCompleted();
    } else {
      return currentRefresh.refreshFailed();
    }
  }

  void loadData(String idGenre) async {
    if (page <= totalPage) {
      hal.value = hal.value + 1;
      await getCurrent(idGenre, hal.value);
      update();
      return currentRefresh.loadComplete();
    } else {
      return currentRefresh.loadNoData();
    }
  }
}
