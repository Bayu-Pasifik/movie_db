import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/modules/home/controllers/now_playing_controller_controller.dart';
import 'package:movie_db/app/modules/home/controllers/popular_controller.dart';
import 'package:movie_db/app/modules/home/controllers/top_controller.dart';
import 'package:movie_db/app/modules/home/controllers/upcoming_controller_controller.dart';
import 'package:movie_db/app/modules/home/views/home_items_view.dart';
import 'package:movie_db/app/modules/home/views/now_playing_view.dart';
import 'package:movie_db/app/modules/home/views/popular_film_view.dart';
import 'package:movie_db/app/modules/home/views/top_view.dart';
import 'package:movie_db/app/modules/home/views/upcoming_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<UpcomingController>();
    Get.find<NowPlayingController>();
    Get.find<TopController>();
    Get.find<PopularController>();
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _buildScreens() {
      return [
        HomeItemsView(),
        Container(width: 200, height: 200, child: Text("Search")),
        Container(width: 200, height: 200, child: Text("Watch List")),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.search),
          title: ("Search"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.bookmark),
          title: ("Watch List"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
