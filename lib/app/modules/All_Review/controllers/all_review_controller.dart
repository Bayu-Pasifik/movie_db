import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'dart:convert';
import 'package:movie_db/app/data/models/ReviewMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class AllReviewController extends GetxController {
  List<dynamic> reviews = [];
  var page;
  var totalPage;
  var hal = 1.obs;
   RefreshController reviewRefresh = RefreshController(initialRefresh: true);
   Future<List> reviewMovie(String id, int hal) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/reviews?api_key=$apikey&language=en-US&page=$hal');
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
}
