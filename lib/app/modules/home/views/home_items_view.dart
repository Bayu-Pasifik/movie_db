import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/modules/home/controllers/home_controller.dart';
import 'package:movie_db/app/modules/widgets/list_trending.dart';
import 'package:movie_db/app/modules/widgets/List_Now_Playing.dart';
import 'package:movie_db/app/modules/widgets/List_Popular_Movie.dart';
import 'package:movie_db/app/modules/widgets/List_Top_Movie.dart';
import 'package:movie_db/app/modules/widgets/List_Upcoming_Movie.dart';
import 'package:movie_db/app/routes/app_pages.dart';
// import 'now_playing_view.dart';

class HomeItemsView extends GetView<HomeController> {
  final String? userData;
  const HomeItemsView({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
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
            // ! Now Playing
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Now Playing",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.ALL_NOW_PLAYING, arguments: userData);
                  },
                  child: Text("Show All"))
            ]),
            SizedBox(height: 10),
            Container(
                width: context.width,
                height: 200,
                child: ListNowPlaying(
                  userData: userData,
                )),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Upcoming Movie",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.ALL_UPCOMING_MOVIE, arguments: userData);
                  },
                  child: Text("Show All"))
            ]),
            SizedBox(height: 10),
            Container(
                width: context.width,
                height: 200,
                child: ListUpcomingMovie(
                  userData: userData,
                )),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Popular Movie",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.ALL_POPULAR_MOVIE, arguments: userData);
                  },
                  child: Text("Show All"))
            ]),
            SizedBox(height: 10),
            Container(
                width: context.width,
                height: 200,
                child: ListPopularMovie(
                  userData: userData,
                )),
                // ! List Top Movie
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Top Movie",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.ALL_TOP_MOVIE, arguments: userData);
                  },
                  child: Text("Show All"))
            ]),
            SizedBox(height: 10),
            Container(
                width: context.width,
                height: 200,
                child: ListTopMovie(
                  userData: userData,
                )),
          ],
        ),
      ),
    ));
  }
}
