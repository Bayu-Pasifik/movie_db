import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/modules/home/controllers/upcoming_controller_controller.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UpcomingView extends GetView<UpcomingController> {
  const UpcomingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpcomingController>(
      builder: (c) {
        return SmartRefresher(
            controller: c.upcommingRefresh,
            enablePullDown: true,
            enablePullUp: true,
            onLoading: () => c.loadData(),
            onRefresh: () => c.refreshData(),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 1 / 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20),
              itemCount: controller.upcomming.length,
              itemBuilder: (context, index) {
                CurrentMovie currentMovie = controller.upcomming[index];
                return GestureDetector(
                  onTap: () =>
                      Get.toNamed(Routes.DETAIL_PAGE, arguments: currentMovie),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/original${currentMovie.posterPath}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              },
            ));
      },
    );
  }
}
