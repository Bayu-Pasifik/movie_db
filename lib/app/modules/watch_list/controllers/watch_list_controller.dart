import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/models/SaveMovie.dart';
import 'package:movie_db/app/modules/Login_Page/controllers/login_page_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WatchListController extends GetxController {
  final _db = FirebaseFirestore.instance;
  RxList<SaveMovie> saved = <SaveMovie>[].obs;
  var savemovie = [].obs;
  List<SaveMovie> saveMovie = [];
  RefreshController watchRefresh = RefreshController(initialRefresh: true);
  // final username = Get.arguments;
  final username = FirebaseAuth.instance.currentUser?.displayName;

  // ! fetch all data
  Future<List<SaveMovie>> getAllSaved() async {
    print("Username on watchlist controller : ${username}");
    final snapshot = await _db
        .collection("savedFilm")
        .where('MadeBy', isEqualTo: "$username")
        .get();

    update();
    final allMovie =
        snapshot.docs.map((e) => SaveMovie.fromSnapshot(e)).toList();
    update();
    var seen = Set<SaveMovie>();
    saveMovie = allMovie.where((element) => seen.add(element)).toList();
    update();
    return saveMovie;
  }

  void refreshData() async {
    if (watchRefresh.initialRefresh == true) {
      await getAllSaved();
      print(saveMovie.length);
      update();
      return watchRefresh.refreshCompleted();
    } else {
      return watchRefresh.refreshFailed();
    }
  }

  @override
  void onInit() {
    // refreshData();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    watchRefresh.dispose();
  }
}
