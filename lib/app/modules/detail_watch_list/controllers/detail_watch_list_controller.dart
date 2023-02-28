import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/models/MovieCast.dart';
import 'package:movie_db/app/data/models/ReviewMovie.dart';
import 'package:movie_db/app/data/models/SaveMovie.dart';
import 'package:movie_db/app/modules/watch_list/controllers/watch_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailWatchListController extends GetxController {
  List<dynamic> reviews = [];
  RefreshController reviewRefresh = RefreshController(initialRefresh: true);
  RefreshController recomRefresh = RefreshController(initialRefresh: true);
  final watchController = Get.find<WatchListController>();

  var page;
  var totalPage;
  var hal = 1.obs;
  List<dynamic> cast = [];
  // ! recomendation
  var totalRecom;
  var pageRecom;
  var halRecom = 1.obs;
  List<dynamic> recom = [];

  // ! save to firebase
  final firestore = FirebaseFirestore.instance;

  Future<DetailMovie> detailMovie(String id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=$apikey&language=en-US');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var tempData = DetailMovie.fromJson(data);
    // debugPrint(tempData.title);
    return tempData;
  }

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

  Future<List> castMovie(String id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=$apikey&language=en-US');
    var response = await http.get(url);
    var data = json.decode(response.body)["cast"];
    var tempData = data.map((e) => MovieCast.fromJson(e)).toList();
    cast.addAll(tempData);
    return cast;
  }

  Future<List> recommendation(String id, int halaman) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/similar?api_key=$apikey&language=en-US&page=$halaman');
    var response = await http.get(url);
    var data = json.decode(response.body)['results'];
    pageRecom = json.decode(response.body)['page'];
    totalRecom = json.decode(response.body)['total_pages'];
    var tempData = data.map((e) => CurrentMovie.fromJson(e)).toList();
    recom.addAll(tempData);
    return recom;
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

  // ! delete watchlist
  void deleteMovie(String docId, String id) async {
    DocumentReference docRef = firestore.collection("savedFilm").doc(docId);
    try {
      Get.defaultDialog(
        title: "Delete Watchlist",
        middleText: "Are you sure want to delete this watchlist ?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () async {
          await docRef.delete();
          Get.back();
          watchController.refreshData();
          Get.back();
        },
      );
    } catch (e) {
      Get.defaultDialog(title: "Error", middleText: "Something went wrong");
    }
  }
}
