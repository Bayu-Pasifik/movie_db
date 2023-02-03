import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/utils.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CurrentMovie detail = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.bookmark))],
        ),
        body: FutureBuilder<DetailMovie>(
          future: controller.detailMovie(detail.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            if (snapshot.data == null) {
              return Center(
                child: Text("Loading....."),
              );
            }
            DetailMovie detailMovie = snapshot.data!;
            return Column(
              children: [
                Stack(
                  children: [
                    // ! Cover Image (Banner image)
                    Container(
                      width: Get.width,
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: "${detailMovie.image}",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    // ! rating bottom right
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 50,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.blueGrey[400]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_outline_outlined,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Text(
                              "${detailMovie.imDbRating}",
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Text("${detailMovie.fullTitle}"),
              ],
            );
          },
        ));
  }
}
