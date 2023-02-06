import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CurrentMovie detail = Get.arguments;
    debugPrint(detail.id.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
          elevation: 0,
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.bookmark))],
        ),
        body: DefaultTabController(
          length: 3,
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
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.amber,
                                  child: Text("${detail.voteCount}"),
                                ),
                              ),
                            ],
                          ),
                          // ! Container for name (movie title)
                          Container(
                            width: Get.width,
                            height: 30,
                            // color: Colors.green,
                            child: Stack(
                              children: [
                                (detail.title!.length <= 20)
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Text("${detail.title}")),
                                      )
                                    : Positioned(
                                        top: 10,
                                        left: 130,
                                        child: Text("${detail.title}")),
                              ],
                            ),
                          ),
                          // ! container for Release date dkk
                          Container(
                            width: Get.width,
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
                                      Text(
                                          "${detailMovie.releaseDate!.year} | "),
                                      Icon(
                                        Icons.access_time,
                                        size: 20,
                                      ),
                                      Text("${detailMovie.runtime} minutes |"),
                                      Icon(
                                        Icons.movie,
                                        size: 20,
                                      ),
                                      Text("${detailMovie.status}")
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
                                    child: Wrap(
                                      children: [
                                        for (var genre in detailMovie.genres!)
                                          Text(
                                            "${genre.name} | ",
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: Get.width,
                            height: 40,
                            // color: Colors.amber,
                            child: TabBar(
                                // isScrollable: true,
                                labelColor: Colors.black,
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
                                ]),
                          ),
                          Expanded(
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              child: TabBarView(children: [
                                Text("About"),
                                Text("Review"),
                                Text("Cast"),
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
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
  }
}
