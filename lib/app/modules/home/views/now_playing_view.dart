import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/modules/home/controllers/now_playing_controller_controller.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NowPlayingView extends GetView<NowPlayingControllerController> {
  const NowPlayingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.currentMovie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 1 / 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20),
            itemCount: controller.current.length,
            itemBuilder: (context, index) {
              CurrentMovie currentMovie = controller.current[index];
              return GestureDetector(
                onTap: () =>
                    Get.toNamed(Routes.DETAIL_PAGE, arguments: currentMovie),
                child: CachedNetworkImage(
                  imageUrl: "${currentMovie.image}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            },
          );
        }
        return Center(
          child: Text("No Data"),
        );
      },
    );
  }
}
