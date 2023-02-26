import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/modules/home/controllers/home_controller.dart';
import 'package:movie_db/app/modules/home/views/popular_film_view.dart';
import 'package:movie_db/app/modules/home/views/top_view.dart';
import 'package:movie_db/app/modules/home/views/upcoming_view.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'now_playing_view.dart';

class HomeItemsView extends GetView<HomeController> {
  final String userData;
  const HomeItemsView({Key? key, required this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String user = Get.arguments;
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
                          fontWeight: FontWeight.w300, fontSize: 22)),
                  Text("${user}",
                      style: GoogleFonts.oleoScript(
                          fontWeight: FontWeight.w300, fontSize: 22))
                ],
              ),
              Text("What do you want to watch ?",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 18)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending Movie",
                    style: GoogleFonts.poppins(),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.TRENDING_PAGE, arguments: userData);
                      },
                      child: Text(
                        "Show All",
                        style: GoogleFonts.poppins(),
                      ))
                ],
              ),
              // ! Listview Trending
              Container(
                height: 150,
                child: FutureBuilder<List>(
                  future: controller.trendingMovie,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            CurrentMovie trending =
                                controller.listTrending[index];
                            return Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: GestureDetector(
                                      onTap: () => Get.toNamed(
                                          Routes.DETAIL_PAGE,
                                          arguments: {
                                            "movie": trending,
                                            "user": userData
                                          }),
                                      child: Container(
                                        width: 100,
                                        height: 150,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original${trending.posterPath}",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/Image_not_available.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${trending.title}",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          overflow: TextOverflow.ellipsis)),
                                ),
                                (trending.releaseDate != "")
                                    ? Text(
                                        "(${trending.releaseDate!.year})",
                                        style: GoogleFonts.poppins(),
                                      )
                                    : Text(
                                        "Null",
                                        style: GoogleFonts.poppins(),
                                      )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                width: 10,
                              ),
                          itemCount: controller.listTrending.length);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
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
                  NowPlayingView(userData: user),
                  UpcomingView(userData: user),
                  TopView(
                    userData: user,
                  ),
                  PopularFilmView(userData: user)
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
