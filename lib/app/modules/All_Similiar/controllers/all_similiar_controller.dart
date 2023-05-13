import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'dart:convert';

import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllSimiliarController extends GetxController {
  var totalRecom;
  var pageRecom;
  var halRecom = 1.obs;
  List<dynamic> recom = [];
  RefreshController recomRefresh = RefreshController(initialRefresh: true);
  Future<List> recommendation(String id, int halaman) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/recommendations?api_key=$apikey&language=en-US&page=$halaman');
    var response = await http.get(url);
    var data = json.decode(response.body)['results'];
    pageRecom = json.decode(response.body)['page'];
    totalRecom = json.decode(response.body)['total_pages'];
    var tempData = data.map((e) => CurrentMovie.fromJson(e)).toList();
    recom.addAll(tempData);
    print(recom.length);
    return recom;
  }

  void refreshRec(String id) async {
    if (recomRefresh.initialRefresh == true) {
      halRecom.value = 1;
      await recommendation(id, halRecom.value);
      update();
      return recomRefresh.refreshCompleted();
    } else {
      return recomRefresh.refreshFailed();
    }
  }

  void loadRec(String id) async {
    if (pageRecom <= totalRecom) {
      halRecom.value = halRecom.value + 1;
      await recommendation(id, halRecom.value);
      update();
      return recomRefresh.loadComplete();
    } else {
      return recomRefresh.loadNoData();
    }
  }
}
