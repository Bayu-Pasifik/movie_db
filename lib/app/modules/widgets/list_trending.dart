import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/routes/app_pages.dart';

class ListTrending extends StatelessWidget {
  const ListTrending({
    super.key,
    required this.controller,
    required this.userData,
  });

  final HomeController controller;
  final String? userData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: controller.trendingMovie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          CurrentMovie trending1 = controller.listTrending[0];
          CurrentMovie trending2 = controller.listTrending[1];
          CurrentMovie trending3 = controller.listTrending[2];
          CurrentMovie trending4 = controller.listTrending[3];
          CurrentMovie trending5 = controller.listTrending[4];
          CurrentMovie trending6 = controller.listTrending[5];
          CurrentMovie trending7 = controller.listTrending[6];
          CurrentMovie trending8 = controller.listTrending[7];
          CurrentMovie trending9 = controller.listTrending[8];
          CurrentMovie trending10 = controller.listTrending[9];
          List<Widget> trendingWidget = [
            // ! List 1
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending1,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[0].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[0].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[0].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[0].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 2
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending2,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[1].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[1].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[1].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[1].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 3
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending3,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[2].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[2].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[2].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[2].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 4
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending4,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[3].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[3].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[3].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[3].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 5
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending5,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[4].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[4].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[4].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[4].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 6
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending6,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[5].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[5].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[5].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[5].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 7
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending7,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[6].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[6].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[6].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[6].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 8
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending8,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[7].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[7].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[7].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[7].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 9
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending9,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[8].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[8].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[8].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[8].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
            // ! List 10
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                          "movie": trending10,
                          "user": userData
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original${controller.listTrending[9].posterPath}",
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
                  ),
                ),
                Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    "${controller.listTrending[9].title}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
                (controller.listTrending[9].releaseDate != "")
                    ? Text(
                        "(${controller.listTrending[9].releaseDate?.year})",
                        style: GoogleFonts.poppins(),
                      )
                    : Text("Null", style: GoogleFonts.poppins())
              ],
            ),
          ];
          return CarouselSlider(
            items: trendingWidget,
            carouselController: controller.carouselController,
            options: CarouselOptions(
                viewportFraction: 0.4,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  controller.currentSlider.value = index;
                }),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}