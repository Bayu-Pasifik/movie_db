import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  Future<List<CurrentMovie>?> getCurrent() async {
    Uri url = Uri.parse('$nowPlaying');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['items'];
      var tempData = data.map((e) => CurrentMovie.fromJson(e)).toList();
      update();
      return tempData;
    } else {
      return null;
    }
  }
}
