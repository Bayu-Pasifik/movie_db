import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/modules/home/controllers/now_playing_controller_controller.dart';
import 'package:movie_db/app/modules/home/controllers/popular_controller.dart';
import 'package:movie_db/app/modules/home/controllers/top_controller.dart';
import 'package:movie_db/app/modules/home/controllers/upcoming_controller_controller.dart';
import 'package:movie_db/app/modules/home/views/home_items_view.dart';
import 'package:movie_db/app/modules/list_genre/controllers/list_genre_controller.dart';
import 'package:movie_db/app/modules/list_genre/views/list_genre_view.dart';
import 'package:movie_db/app/modules/search/controllers/search_controller.dart';
import 'package:movie_db/app/modules/search/views/search_view.dart';
import 'package:movie_db/app/modules/watch_list/controllers/watch_list_controller.dart';
import 'package:movie_db/app/modules/watch_list/views/watch_list_view.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ListGenreController());
    Get.put(SearchController());
    Get.put(WatchListController());
    Get.put(NowPlayingController());
    Get.put(TopController());
    Get.put(UpcomingController());
    Get.put(PopularController());
    Get.put(ListGenreController());
    final String username = Get.arguments;
    print("Username on homeView : $username");
    List<Widget> widgets = [
      HomeItemsView(),
      SearchView(),
      WatchListView(
        userData: username,
      ),
      ListGenreView(),
    ];
    return Scaffold(
        bottomNavigationBar: Obx(
          () => CurvedNavigationBar(
            // key: _bottomNavigationKey,
            index: controller.tabIndex.value,
            height: 60.0,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.list, size: 30),
              Icon(Icons.compare_arrows, size: 30),
              Icon(Icons.call_split, size: 30),
              // Icon(Icons.perm_identity, size: 30),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.blueGrey,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
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
