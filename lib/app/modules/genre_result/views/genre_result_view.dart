import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/GenreMovie.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/genre_result_controller.dart';

class GenreResultView extends GetView<GenreResultController> {
  const GenreResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GenreMovie genreMovie = Get.arguments["movie"];
    String userData = Get.arguments["user"];
    return Scaffold(
        appBar: AppBar(
          title: Text('${genreMovie.name}'),
          centerTitle: true,
        ),
        body: GetBuilder<GenreResultController>(
          builder: (c) {
            return SmartRefresher(
                controller: c.currentRefresh,
                enablePullDown: true,
                enablePullUp: true,
                onLoading: () => c.loadData(genreMovie.id.toString()),
                onRefresh: () => c.refreshData(genreMovie.id.toString()),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 1 / 1.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20),
                  itemCount: controller.current.length,
                  itemBuilder: (context, index) {
                    CurrentMovie currentMovie = controller.current[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: 200,
                              height: 200,
                              child: GestureDetector(
                                onTap: () => Get.toNamed(Routes.DETAIL_PAGE,
                                    arguments: {
                                      "movie": currentMovie,
                                      "user": userData
                                    }),
                                child: (currentMovie.posterPath != null)
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/original/${currentMovie.posterPath}",
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
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assets/images/Image_not_available.png"),
                                      )
                                    : Image.asset(
                                        "assets/images/Image_not_available.png"),
                              ),
                            ),
                          ),
                          Text(
                            "${currentMovie.title}",
                            style: GoogleFonts.poppins(
                                textStyle:
                                    TextStyle(overflow: TextOverflow.ellipsis)),
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
                      ),
                    );
                  },
                ));
          },
        ));
  }
}
