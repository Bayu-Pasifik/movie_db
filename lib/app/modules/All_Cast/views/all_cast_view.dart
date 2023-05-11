import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/models/MovieCast.dart';

import '../controllers/all_cast_controller.dart';

class AllCastView extends GetView<AllCastController> {
  const AllCastView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DetailMovie detailMovie = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("All Cast ${detailMovie.title}")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: controller.castMovie(detailMovie.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return (controller.cast.length != 0)
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          MovieCast cast = controller.cast[index];
                          return Container(
                            width: 400,
                            height: 200,
                            // color: Colors.amber,
                            child: Row(children: [
                              Expanded(
                                child: Container(
                                    width: 50,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Full Name : "),
                                        Text("${cast.originalName}"),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Center(child: Text("As")),
                                    SizedBox(height: 10),
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
                                ),
                              )
                            ]),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                        itemCount: controller.cast.length)
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
