import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/GenreMovie.dart';
import 'dart:convert';

class ListGenreController extends GetxController {
  List allGenre = [];
  late Future<List> genres;
  Future<List> getGenre() async {
    Uri url = Uri.parse('$genreMovie');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['genres'];
      var tempdata = data.map((e) => GenreMovie.fromJson(e)).toList();
      allGenre.addAll(tempdata);
    }
    return allGenre;
  }

  @override
  void onInit() {
    super.onInit();
    genres = getGenre();
  }
}
