import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_db/app/data/api.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  var auth = FirebaseAuth.instance;
  Rx<int> tabIndex = 0.obs;
  var hal = 1.obs;
  RefreshController trendingRefresh = RefreshController(initialRefresh: true);
  List<dynamic> listTrending = [];
  late Future<List> trendingMovie;
  var page;
  var totalPage;
  var message = ''.obs;
  Future<List> getCurrent() async {
    Uri url = Uri.parse('$trending');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'];
      page = json.decode(response.body)['page'];
      totalPage = json.decode(response.body)['total_pages'];
      var tempdata = data.map((e) => CurrentMovie.fromJson(e)).toList();
      print(tempdata);
      listTrending.addAll(tempdata);
      print("page : $page");
      print("total : $totalPage");
    }
    return listTrending;
  }

  void refreshData() async {
    if (trendingRefresh.initialRefresh == true) {
      hal.value = 1;
      await getCurrent();
      update();
      return trendingRefresh.refreshCompleted();
    } else {
      return trendingRefresh.refreshFailed();
    }
  }

  void loadData() async {
    if (page <= totalPage) {
      hal.value = hal.value + 1;
      await getCurrent();
      update();
      return trendingRefresh.loadComplete();
    } else {
      return trendingRefresh.loadNoData();
    }
  }

  void chagePage(int index) {
    tabIndex.value = index;
    update();
  }

  String greetings() {
    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));
    if (timeNow <= 12) {
      return message.value = 'Good Morning';
    } else if ((timeNow > 12) && timeNow <= 16) {
      return message.value = 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return message.value = 'Good Evening';
    }
    return 'Good Night';
  }

  // ! Logout Account
  void logout() async {
    await auth.signOut();
    //Get.offAllNamed(Routes.LOGIN_PAGE);
  }

  @override
  void onInit() {
    super.onInit();
    trendingMovie = getCurrent();
  }

  @override
  void dispose() {
    super.dispose();
    trendingRefresh.dispose();
  }
}
