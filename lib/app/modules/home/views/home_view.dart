import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/modules/All_Now_Playing/controllers/all_now_playing_controller.dart';
import 'package:movie_db/app/modules/All_Popular_Movie/controllers/all_popular_movie_controller.dart';
import 'package:movie_db/app/modules/All_Top_Movie/controllers/all_top_movie_controller.dart';
import 'package:movie_db/app/modules/All_Upcoming_Movie/controllers/all_upcoming_movie_controller.dart';
import 'package:movie_db/app/modules/home/controllers/top_controller.dart';
import 'package:movie_db/app/modules/home/views/home_items_view.dart';
import 'package:movie_db/app/modules/list_genre/controllers/list_genre_controller.dart';
import 'package:movie_db/app/modules/list_genre/views/list_genre_view.dart';
import 'package:movie_db/app/modules/search/controllers/search_controller.dart';
import 'package:movie_db/app/modules/search/views/search_view.dart';
import 'package:movie_db/app/modules/watch_list/controllers/watch_list_controller.dart';
import 'package:movie_db/app/modules/watch_list/views/watch_list_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final String? userData;
  const HomeView({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ListGenreController());
    final search = Get.put(SearchC());
    Get.put(WatchListController());
    Get.put(AllNowPlayingController());
    Get.put(AllTopMovieController());
    Get.put(AllUpcomingMovieController());
    Get.put(AllPopularMovieController());
    Get.put(ListGenreController());
    final currentUser = FirebaseAuth.instance.currentUser;
    print("Username on homeView : ${currentUser?.displayName}");
    List<Widget> widgets = [
      HomeItemsView(userData: currentUser?.displayName ?? "no data"),
      SearchView(userData: currentUser?.displayName),
      WatchListView(userData: currentUser?.displayName),
      ListGenreView(userData: currentUser?.displayName),
    ];
    return Scaffold(
        bottomNavigationBar: Obx(
          () => CurvedNavigationBar(
            index: controller.tabIndex.value,
            height: 60.0,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.search, size: 30),
              Icon(Icons.watch_later, size: 30),
              Icon(Icons.movie_creation_outlined, size: 30),
              // Icon(Icons.perm_identity, size: 30),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.black12,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              if (index != 1) {
                search.searchController.clear();
                search.searchMovieController.itemList?.clear();
              }
              controller.chagePage(index);
            },
            letIndexChange: (index) => true,
          ),
        ),
        body: GetBuilder<HomeController>(
          builder: (c) => widgets[c.tabIndex.value],
        ));
  }
}
