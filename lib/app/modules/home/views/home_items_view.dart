
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/modules/home/controllers/home_controller.dart';
import 'package:movie_db/app/modules/home/views/list_trending.dart';
import 'package:movie_db/app/modules/home/views/popular_film_view.dart';
import 'package:movie_db/app/modules/home/views/top_view.dart';
import 'package:movie_db/app/modules/home/views/upcoming_view.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'now_playing_view.dart';

class HomeItemsView extends GetView<HomeController> {
  final String? userData;
  const HomeItemsView({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ! Greetings
              Row(
                children: [
                  Text("${controller.greetings()} ",
                      style: GoogleFonts.oleoScript(
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                          color: Colors.grey[600])),
                  Text("$userData",
                      style: GoogleFonts.oleoScript(
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                          color: Colors.grey[600])),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        controller.logout();
                        Get.offAllNamed(Routes.LOGIN_PAGE);
                      },
                      icon: Icon(Icons.logout))
                ],
              ),
              Text("What do you want to watch ?",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.grey[600])),
              SizedBox(
                height: 20,
              ),
              // ! List Trending 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending Movie",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.TRENDING_PAGE, arguments: userData);
                      },
                      child: Text(
                        "Show All",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                      ))
                ],
              ),
              // ! Listview Trending
              Container(
                height: 200,
                width: context.width,
                child: ListTrending(controller: controller, userData: userData),
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(
                  labelStyle: GoogleFonts.poppins(),
                  isScrollable: true,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "Currently Airing",
                    ),
                    Tab(
                      text: "Upcoming",
                    ),
                    Tab(
                      text: "Top Rated",
                    ),
                    Tab(
                      text: "Popular",
                    ),
                  ]),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(children: [
                  NowPlayingView(userData: userData),
                  UpcomingView(userData: userData),
                  TopView(userData: userData),
                  PopularFilmView(userData: userData)
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
