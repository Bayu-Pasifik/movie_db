import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/models/SaveMovie.dart';

import 'package:movie_db/app/modules/DetailPage/views/cast_view.dart';
import 'package:movie_db/app/modules/DetailPage/views/review_items_view.dart';
import 'package:movie_db/app/modules/DetailPage/views/trailers_item.dart';
import 'package:movie_db/app/modules/DetailPage/views/video_item.dart';
import 'package:movie_db/app/modules/home/views/similar_view.dart';
import 'package:movie_db/app/modules/watch_list/controllers/watch_list_controller.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CurrentMovie detail = Get.arguments["movie"];
    print(detail.id);
    final String username = Get.arguments["user"];
    DateTime now = DateTime.now();
    final String date = now.toString().substring(0, 10);
    final movie = SaveMovie(
        name: detail.title.toString(),
        rating: detail.voteAverage.toString(),
        imageUrl: "https://image.tmdb.org/t/p/original${detail.posterPath}",
        createdAt: date,
        idMovie: detail.id.toString(),
        madeBy: username);
    return Scaffold(
      //1
      body: CustomScrollView(
        slivers: [
          //2
          SliverAppBar(
            snap: true,
            floating: true,
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {
                    controller.createSave(movie);
                  },
                  icon: Obx(() => (controller.saved.isFalse)
                      ? Icon(Icons.bookmark)
                      : Icon(Icons.bookmark_added_sharp)))
            ],
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${detail.title}', style: GoogleFonts.poppins()),
              background: CachedNetworkImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/original${detail.posterPath}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/Image_not_available.png"),
              ),
            ),
          ),
          //3

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return FutureBuilder(
                  future: controller.detailfilm,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                    DetailMovie detailMovie = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ! Trailers
                          Text("Trailer",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 15)),
                          SizedBox(height: 10),
                          Container(
                              height: 200,
                              width: context.width,
                              child: TrailersItem(id: detailMovie.id!)),
                          SizedBox(height: 20),
                          // ! Release date
                          Text(
                            "Release Date",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(width: 5),
                              Text(
                                  "${detail.releaseDate?.day} - ${detail.releaseDate?.month} - ${detail.releaseDate?.year}",
                                  style: GoogleFonts.poppins())
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Genres",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            children: [
                              for (var genres in detailMovie.genres!)
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Chip(
                                    label: Text("${genres.name}"),
                                    backgroundColor: Colors.blue,
                                    labelStyle: GoogleFonts.poppins(
                                        color: Colors.white),
                                    labelPadding: EdgeInsets.all(5),
                                  ),
                                )
                            ],
                          ),
                          SizedBox(height: 20),
                          // ! Overview
                          Text(
                            "Overview",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${detail.overview}",
                            style: GoogleFonts.poppins(),
                          ),
                          SizedBox(height: 20),
                          // ! Summary
                          Text(
                            "Summary",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(height: 20),
                          Table(
                            border: TableBorder.all(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Colors.black12),
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Rating",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${detailMovie.voteAverage}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Adult",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                                (detailMovie.adult == false)
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "No",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Yes",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Popularity",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${detailMovie.popularity} Peoples",
                                    style: GoogleFonts.poppins(),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Status",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${detailMovie.status}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Budget",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${detailMovie.budget}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Revenue",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${detailMovie.revenue}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                )
                              ]),
                            ],
                          ),
                          SizedBox(height: 20),
                          // ! Cast
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cast",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.ALL_CAST,
                                        arguments: detailMovie);
                                  },
                                  child: Text(
                                    "Load More",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                              height: 300,
                              child: CastView(id: detailMovie.id.toString())),
                          SizedBox(height: 20),
                          // ! Review
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Review",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.ALL_REVIEW,
                                      arguments: detailMovie);
                                },
                                child: Text(
                                  "Load More",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                              height: 300,
                              child: ReviewItemsView(
                                  id: detailMovie.id.toString())),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recomendation",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              TextButton(
                                  onPressed: () => Get.toNamed(
                                      Routes.ALL_SIMILIAR,
                                      arguments: detailMovie),
                                  child: Text(
                                    "Load More",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                              height: 200,
                              color: Colors.amber,
                              child: SimilarView(id: detail.id!)),
                          SizedBox(height: 50)
                        ],
                      ),
                    );
                  },
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
