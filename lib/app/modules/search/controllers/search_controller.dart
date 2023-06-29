import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchC extends GetxController {
  late TextEditingController searchController;

  final PagingController<int, CurrentMovie> searchMovieController =
      PagingController<int, CurrentMovie>(firstPageKey: 1);

  void searchMovie(String query, int pageKey) async {
    try {
      Uri url = Uri.parse(
          '$searchMov&query=$query&page=$pageKey&include_adult=false');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["results"];
      var data = tempData.map((e) => CurrentMovie.fromJson(e)).toList();
      List<CurrentMovie> allSearch = List<CurrentMovie>.from(data);

      final nextPage = json.decode(response.body)["page"];
      final totalPage = json.decode(response.body)["total_pages"];
      final isLastPage = nextPage == totalPage;

      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        searchMovieController.appendLastPage(allSearch);
      } else {
        searchMovieController.appendPage(allSearch, pageKey + 1);
        print("Pagekey di searchMovie: $pageKey");
      }
    } catch (e) {
      searchMovieController.error = e;
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
    searchMovieController.addPageRequestListener((pageKey) {
      searchMovie(searchController.text, pageKey);
      print("Pagekey di init: $pageKey");
    });
    searchController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    searchMovieController.dispose();
    searchController.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    searchMovieController.dispose();
    searchController.dispose();
  }
}
