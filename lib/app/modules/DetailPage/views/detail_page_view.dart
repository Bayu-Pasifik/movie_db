import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';

import 'package:movie_db/app/modules/DetailPage/views/cast_view.dart';
import 'package:movie_db/app/modules/DetailPage/views/review_items_view.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CurrentMovie detail = Get.arguments;
    debugPrint(detail.id.toString());
    return GetBuilder<DetailPageController>(
      builder: (c) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Detail',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              ),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.bookmark))
              ],
            ),
            body: DefaultTabController(
              length: 4,
              child: FutureBuilder<DetailMovie>(
                future: controller.detailfilm,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      DetailMovie detailMovie = snapshot.data!;
                      return Stack(
                        children: [
                          Column(
                            children: [
                              // ! Stack for backround image and rating
                              Stack(
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: 200,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/original${detail.posterPath}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8)),
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
                                  Positioned(
                                    top: 180,
                                    left: 300,
                                    child: Container(
                                      width: 60,
                                      height: 20,
                                      // color: Colors.amber,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star_border,
                                            color: Colors.orange[600],
                                            size: 20,
                                          ),
                                          Text(
                                            "${detailMovie.voteAverage}",
                                            style: TextStyle(
                                                color: Colors.orange[600]),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 56, 78, 116)
                                                  .withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                  ),
                                ],
                              ),
                              // ! Container for name (movie title)
                              Container(
                                width: 400,
                                height: 80,
                                // color: Colors.green,
                                child: Stack(
                                  children: [
                                    (detail.title!.length <= 20)
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  "${detail.title}",
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18),
                                                )),
                                          )
                                        : Positioned(
                                            // top: 10,
                                            left: 100,
                                            child: Container(
                                              width: context.width / 1.5,
                                              height: 60,
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    "${detail.title}",
                                                    softWrap: true,
                                                    maxLines: 4,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                  ],
                                ),
                              ),
                              // ! container for Release date dkk
                              Container(
                                width: context.width,
                                height: 30,
                                // color: Colors.green,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 100,
                                      top: 5,
                                      child: Wrap(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            size: 20,
                                          ),
                                          (detailMovie.releaseDate != null)
                                              ? Text(
                                                  "${detailMovie.releaseDate!.year} | ",
                                                  style:
                                                      GoogleFonts.montserrat(),
                                                )
                                              : Text("Null | "),
                                          Icon(
                                            Icons.access_time,
                                            size: 20,
                                          ),
                                          (detailMovie.runtime != null)
                                              ? Text(
                                                  "${detailMovie.runtime} minutes |",
                                                  style:
                                                      GoogleFonts.montserrat(),
                                                )
                                              : Text("Null"),
                                          Icon(
                                            Icons.movie,
                                            size: 20,
                                          ),
                                          (detailMovie.status != null)
                                              ? Text(
                                                  "${detailMovie.status}",
                                                  style:
                                                      GoogleFonts.montserrat(),
                                                )
                                              : Text("Null")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ! container for genre
                              Container(
                                width: Get.width,
                                height: 50,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 100,
                                      child: Container(
                                        width: Get.width / 1.2,
                                        height: 50,
                                        // color: Colors.amber,
                                        child: (detailMovie.genres != null)
                                            ? Wrap(
                                                children: [
                                                  for (var genre
                                                      in detailMovie.genres!)
                                                    Text(
                                                      "${genre.name} | ",
                                                      style: GoogleFonts
                                                          .montserrat(),
                                                    )
                                                ],
                                              )
                                            : Text("Null"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ! container for tab bar
                              Container(
                                width: Get.width,
                                height: 40,
                                // color: Colors.amber,
                                child: TabBar(
                                    isScrollable: true,
                                    labelColor: Colors.black,
                                    labelStyle: GoogleFonts.poppins(),
                                    tabs: [
                                      Tab(
                                        text: "About Movie",
                                      ),
                                      Tab(
                                        text: "Reviews",
                                      ),
                                      Tab(
                                        text: "Cast",
                                      ),
                                      Tab(
                                        text: "Recomendation",
                                      ),
                                    ]),
                              ),
                              // ! tabbar view
                              Expanded(
                                child: Container(
                                  width: context.width,
                                  height: context.height,
                                  child: TabBarView(children: [
                                    // ! overview
                                    (detailMovie.overview != "")
                                        ? Text(
                                            "${detailMovie.overview}",
                                            style: GoogleFonts.poppins(),
                                          )
                                        : Center(
                                            child: Text(
                                              "There Is No Data Overview",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                    ReviewItemsView(
                                        id: detailMovie.id.toString()),
                                    CastView(id: detailMovie.id.toString()),
                                    GetBuilder<DetailPageController>(
                                      builder: (c) {
                                        return SmartRefresher(
                                            controller: c.recomRefresh,
                                            enablePullDown: true,
                                            enablePullUp: true,
                                            onLoading: () => c.loadRec(
                                                detailMovie.id.toString()),
                                            onRefresh: () => c.refreshRec(
                                                detailMovie.id.toString()),
                                            child: (c.recom.length != 0)
                                                ? ListView.separated(
                                                    itemCount: c.recom.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox(
                                                        height: 20,
                                                      );
                                                    },
                                                    itemBuilder:
                                                        (context, index) {
                                                      CurrentMovie recomend =
                                                          c.recom[index];
                                                      return Material(
                                                        elevation: 1,
                                                        child: ListTile(
                                                          leading: Container(
                                                            width: 100,
                                                            height: 200,
                                                            child: (recomend
                                                                        .posterPath !=
                                                                    null)
                                                                ? CachedNetworkImage(
                                                                    imageUrl:
                                                                        "https://image.tmdb.org/t/p/original${recomend.posterPath}",
                                                                    progressIndicatorBuilder: (context,
                                                                            url,
                                                                            downloadProgress) =>
                                                                        Center(
                                                                      child:
                                                                          Center(
                                                                        child: CircularProgressIndicator(
                                                                            value:
                                                                                downloadProgress.progress),
                                                                      ),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Image.asset(
                                                                            "assets/images/Image_not_available.png"),
                                                                  )
                                                                : Image.asset(
                                                                    "assets/images/Image_not_available.png"),
                                                          ),
                                                          title: Text(
                                                            "${recomend.title}",
                                                            style: GoogleFonts
                                                                .poppins(),
                                                          ),
                                                          subtitle: Row(
                                                            children: [
                                                              Icon(
                                                                  CupertinoIcons
                                                                      .star),
                                                              Text(
                                                                "${recomend.voteAverage ?? "NaN"}",
                                                                style: GoogleFonts
                                                                    .poppins(),
                                                              ),
                                                            ],
                                                          ),
                                                          trailing: Text(
                                                            "${recomend.releaseDate!.year}",
                                                            style: GoogleFonts
                                                                .poppins(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child: Text(
                                                      "There is no data Recommendation",
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    ),
                                                  ));
                                      },
                                    )
                                  ]),
                                ),
                              )
                            ],
                          ),
                          // ! small picture on left side
                          Positioned(
                            top: 120,
                            child: Container(
                              width: 100,
                              height: 150,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/original${detail.posterPath}",
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
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        "assets/images/Image_not_available.png"),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ));
      },
    );
  }
}
