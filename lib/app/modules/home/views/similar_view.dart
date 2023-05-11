import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/modules/DetailPage/controllers/detail_page_controller.dart';

class SimilarView extends GetView<DetailPageController> {
  final int id;
  const SimilarView({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: controller.recommendation(
          this.id.toString(), controller.halRecom.toInt()),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
        }
        return (controller.recom.length != 0)
            ? ListView.separated(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemBuilder: (context, index) {
                  CurrentMovie recomend = controller.recom[index];
                  return Container(
                    width: 150,
                    height: 200,
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 200,
                            height: 200,
                            child: (recomend.posterPath != null)
                                ? CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/original${recomend.posterPath}",
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/Image_not_available.png"),
                                  )
                                : Image.asset(
                                    "assets/images/Image_not_available.png"),
                          ),
                        ),
                        Text("${recomend.title}"),
                        Text("( ${recomend.releaseDate?.year ?? "NaN"} )")
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "There is no data Recommendation",
                  style: GoogleFonts.poppins(),
                ),
              );
      },
    ));
  }
}
