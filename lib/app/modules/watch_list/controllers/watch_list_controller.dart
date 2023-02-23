import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/models/SaveMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WatchListController extends GetxController {
  final _db = FirebaseFirestore.instance;
  RxList<SaveMovie> saved = <SaveMovie>[].obs;
  var savemovie = [].obs;
  List<SaveMovie> saveMovie = [];
  RefreshController watchRefresh = RefreshController(initialRefresh: true);

  // ! fetch all data

  // Future<RxList<SaveMovie>> getAllSaved() async {
  //   final snapshot = await _db.collection("savedFilm").get();
  //   // update();
  //   final allMovie = snapshot.docs.map((e) => SaveMovie.fromSnapshot(e));
  //   // update();
  //   var unique = allMovie.toSet().toList();
  //   saved.addAll(unique);
  //   // update();
  //   saved.refresh();
  //   // update();
  //   print(saved);
  //   print(saved.length);
  //   // update();
  //   return saved;
  // }
  Future<List<SaveMovie>> getAllSaved() async {
    final snapshot = await _db.collection("savedFilm").get();
    update();
    final allMovie =
        snapshot.docs.map((e) => SaveMovie.fromSnapshot(e)).toList();
    update();
    var seen = Set<SaveMovie>();
    saveMovie = allMovie.where((element) => seen.add(element)).toList();
    // saved.addAll(saveMovie);
    update();
    print("length: ${saveMovie.length}");
    print("isi: ${saveMovie}");
    // saveMovie.refresh();
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
