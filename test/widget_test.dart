import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';

void main() async {
  Uri url = Uri.parse('$trending');
  var response = await http.get(url);
  var data = json.decode(response.body)['results'];
  var current = data.map((e) => CurrentMovie.fromJson(e)).toList();
  print(current[1].title);
}
