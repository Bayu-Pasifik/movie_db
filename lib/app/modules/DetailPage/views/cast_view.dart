import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/models/MovieCast.dart';
import 'package:movie_db/app/modules/DetailPage/controllers/detail_page_controller.dart';

class CastView extends GetView<DetailPageController> {
  final String id;
  const CastView({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: controller.castMovie(this.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 40),
                itemCount: controller.cast.length,
                itemBuilder: (context, index) {
                  MovieCast cast = controller.cast[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                              width: 200,
                              height: 200,
                              child: (cast.profilePath != null)
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/original${cast.profilePath}",
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : CircleAvatar(
                                      child: Image.asset(
                                          "assets/images/Image_not_available.png"),
                                    )),
                        ),
                        Text("${cast.originalName}"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("As"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${cast.character}")
                      ],
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}