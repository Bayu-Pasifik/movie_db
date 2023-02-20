import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/models/SaveMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WatchListController extends GetxController {
  final _db = FirebaseFirestore.instance;
  List<SaveMovie> saved = [];
  RefreshController watchRefresh = RefreshController(initialRefresh: true);

  // ! fetch all data

  Future<List<SaveMovie>> getAllSaved() async {
    final snapshot = await _db.collection("savedFilm").get();
    final allMovie =
        snapshot.docs.map((e) => SaveMovie.fromSnapshot(e)).toList();
    update();
    saved.addAll(allMovie);
    print("Data saved : $saved");
    print("length saved : ${saved.length}");
    update();
    return saved;
  }

  void refreshData() async {
    if (watchRefresh.initialRefresh == true) {
      await getAllSaved();
      update();
      return watchRefresh.refreshCompleted();
    } else {
      return watchRefresh.refreshFailed();
    }
  }

  // void loadData(String id) async {
  //   if (page <= totalPage) {
  //     hal.value = hal.value + 1;
  //     await reviewMovie(id, hal.value);
  //     update();
  //     return reviewRefresh.loadComplete();
  //   } else {
  //     return reviewRefresh.loadNoData();
  //   }
  // }
}
