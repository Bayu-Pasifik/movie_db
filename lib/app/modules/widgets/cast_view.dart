import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/MovieCast.dart';
import 'package:movie_db/app/modules/DetailPage/controllers/detail_page_controller.dart';

class CastView extends GetView<DetailPageController> {
  final String id;
  const CastView({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: controller.castMovie(this.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return (controller.cast.length != 0)
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          MovieCast cast = controller.cast[index];
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
                                    width: 200,
                                    height: 400,
                                    child: (cast.profilePath != null)
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/original${cast.profilePath}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                // shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/Image_not_available.png"),
                                          )
                                        : Image.asset(
                                            "assets/images/Image_not_available.png")),
                              ),
                              Text(
                                "${cast.originalName}",
                                style: GoogleFonts.poppins(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "As",
                                style: GoogleFonts.poppins(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              (cast.character != "")
                                  ? Text(
                                      "${cast.character}",
                                      style: GoogleFonts.poppins(),
                                    )
                                  : Text(
                                      "Null",
                                      style: GoogleFonts.poppins(),
                                    )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        itemCount: 5)
                    : Center(
                        child: Text(
                          "There Is No Data Cast",
                          style: GoogleFonts.poppins(),
                        ),
                      );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
