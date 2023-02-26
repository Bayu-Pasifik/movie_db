import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/models/GenreMovie.dart';

void main() async {
  // Uri url = Uri.parse('$genreMovie');
  // var response = await http.get(url);
  // if (response.statusCode == 200) {
  //   var data = json.decode(response.body)['genres'];
  //   var tempdata = data.map((e) => GenreMovie.fromJson(e)).toList();
  //   print(tempdata[1].name);
  // }
  DateTime now = DateTime.now();
  final String date = now.toString().substring(11, 16);

  print(date);
}
