import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_db/app/data/models/SaveMovie.dart';
import 'package:movie_db/app/modules/home/controllers/watch_list_controller.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WatchListView extends GetView<WatchListController> {
  const WatchListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchListController>(
      builder: (c) {
        return SafeArea(
            child: (c.saved.length != 0 || c.saved != [])
                ? SmartRefresher(
                    controller: c.watchRefresh,
                    onRefresh: () => c.refreshData(),
                    child: ListView.builder(
                      itemCount: c.saved.length,
                      itemBuilder: (context, index) {
                        SaveMovie saveMovie = c.saved[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_PAGE,
                                arguments: {"id": saveMovie.id});
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
                                          color: Colors.grey[100],
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
                    ),
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
                  ));
      },
    );
  }
}
