import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/modules/home/controllers/top_controller_controller.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopView extends GetView<TopController> {
  const TopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopController>(
      builder: (c) {
        return SmartRefresher(
            controller: c.topRefresh,
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
              itemCount: controller.top.length,
              itemBuilder: (context, index) {
                CurrentMovie currentMovie = controller.top[index];
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
