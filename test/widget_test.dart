import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/models/GenreMovie.dart';
import 'package:movie_db/app/data/models/TrailerModel.dart';

void main() async {
  Uri url = Uri.parse(
      'https://api.themoviedb.org/3/movie/502356/videos?api_key=$apikey&language=en-US');
  var response = await http.get(url);
  var data = json.decode(response.body)["results"];
  var tempData = data.map((e) => TrailerModel.fromJson(e)).toList();
  print(tempData);
  for (var official in tempData) {
    print(official);
  }
}
