import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_db/app/data/models/SaveMovie.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/watch_list_controller.dart';

class WatchListView extends GetView<WatchListController> {
  final String? userData;
  const WatchListView({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Watchlist"),
          elevation: 0,
        ),
        body: GetBuilder<WatchListController>(
          builder: (c) {
            return SmartRefresher(
              controller: c.watchRefresh,
              onRefresh: () => c.refreshData(),
              child: (c.saveMovie.isNotEmpty)
                  ? ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: c.saveMovie.length,
                      itemBuilder: (context, index) {
                        SaveMovie saveMovie = c.saveMovie[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_WATCH_LIST,
                                arguments: saveMovie.idMovie);
                          },
                          child: Row(
                            children: [
                              // ! image on the left
                              Container(
                                width: 100,
                                height: 150,
                                child: CachedNetworkImage(
                                  imageUrl: "${saveMovie.imageUrl}",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: context.width,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${saveMovie.name}",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(CupertinoIcons.star),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "${saveMovie.rating}",
                                                style: GoogleFonts.poppins(),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(CupertinoIcons.calendar),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "${saveMovie.createdAt}",
                                                style: GoogleFonts.poppins(),
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset("assets/lottie/popcorn.json"),
                        Text(
                          "No Data Yet",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ],
                    ),
            );
          },
        ));
  }
}
