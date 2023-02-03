import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';

void main() async {
  Uri url = Uri.parse('https://imdb-api.com/en/API/Title/k_xjxbwxh7/tt0411008');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var tempData = DetailMovie.fromJson(data);
    // debugPrint(tempData[1].title.toString());
    debugPrint(tempData.title);
  }
}
