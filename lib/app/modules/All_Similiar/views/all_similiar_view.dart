import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/modules/DetailPage/controllers/detail_page_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/all_similiar_controller.dart';

class AllSimiliarView extends GetView<AllSimiliarController> {
  const AllSimiliarView({Key? key, required}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DetailMovie detailMovie = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Recommendation"),
          centerTitle: true,
        ),
        body: GetBuilder<AllSimiliarController>(
          builder: (c) {
            return SmartRefresher(
                controller: c.recomRefresh,
                enablePullDown: true,
                enablePullUp: true,
                onLoading: () => c.loadRec(detailMovie.id.toString()),
                onRefresh: () => c.refreshRec(detailMovie.id.toString()),
                child: (c.recom.length != 0)
                    ? GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                childAspectRatio: 1 / 1.8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20),
                        itemCount: controller.recom.length,
                        itemBuilder: (context, index) {
                          CurrentMovie currentMovie = controller.recom[index];
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/original${currentMovie.posterPath}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                              Text(
                                "${currentMovie.title}",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        overflow: TextOverflow.ellipsis)),
                              ),
                              (currentMovie.releaseDate != "")
                                  ? Text(
                                      "(${currentMovie.releaseDate?.year})",
                                      style: GoogleFonts.poppins(),
                                    )
                                  : Text(
                                      "Null",
                                      style: GoogleFonts.poppins(),
                                    )
                            ],
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "There is no data Recommendation",
                          style: GoogleFonts.poppins(),
                        ),
                      ));
          },
        ));
  }
}
