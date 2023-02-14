import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/modules/DetailPage/controllers/detail_page_controller.dart';
import 'package:movie_db/app/modules/home/controllers/home_controller.dart';
import 'package:movie_db/app/modules/home/views/popular_film_view.dart';
import 'package:movie_db/app/modules/home/views/top_view.dart';
import 'package:movie_db/app/modules/home/views/upcoming_view.dart';
import 'package:movie_db/app/routes/app_pages.dart';

import '../controllers/now_playing_controller_controller.dart';
import '../controllers/popular_controller.dart';
import '../controllers/top_controller.dart';
import '../controllers/upcoming_controller_controller.dart';
import 'now_playing_view.dart';

class HomeItemsView extends GetView<HomeController> {
  const HomeItemsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<UpcomingController>();
    Get.find<NowPlayingController>();
    Get.find<TopController>();
    Get.find<PopularController>();
    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What do you want to watch ?",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Trending Movie"),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.TRENDING_PAGE);
                      },
                      child: Text("Show All"))
                ],
              ),
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
                            return GestureDetector(
                              onTap: () => Get.toNamed(Routes.DETAIL_PAGE,
                                  arguments: trending),
                              child: Container(
                                width: 100,
                                height: 150,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/original${trending.posterPath}",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/Image_not_available.png"),
                                ),
                              ),
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
              TabBar(isScrollable: true, labelColor: Colors.black, tabs: [
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
                  NowPlayingView(),
                  UpcomingView(),
                  TopView(),
                  PopularFilmView()
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
