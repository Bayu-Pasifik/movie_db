import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/MovieCast.dart';



class AllCastController extends GetxController {
  List<dynamic> cast = [];
    Future<List> castMovie(String id) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=$apikey&language=en-US');
    var response = await http.get(url);
    var data = json.decode(response.body)["cast"];
    var tempData = data.map((e) => MovieCast.fromJson(e)).toList();
    cast.addAll(tempData);
    return cast;
  }
}
