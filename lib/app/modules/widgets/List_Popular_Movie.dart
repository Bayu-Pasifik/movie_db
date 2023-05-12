import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/modules/All_Popular_Movie/controllers/all_popular_movie_controller.dart';
import 'package:movie_db/app/routes/app_pages.dart';


class ListPopularMovie extends GetView<AllPopularMovieController> {
  final String? userData;
  const ListPopularMovie({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getCurrent(controller.hal.toInt()),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
        }
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              CurrentMovie currentMovie = controller.popularity[index];
              return Container(
                height: 100,
                width: 100,
                // color: Colors.amber,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_PAGE, arguments: {
                              "movie": currentMovie,
                              "user": userData
                            });
                          },
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/original${currentMovie.posterPath}",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                                "assets/images/Image_not_available.png"),
                          ),
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
                        : Text("Null", style: GoogleFonts.poppins())
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
            itemCount: 10);
      },
    );
  }
}
