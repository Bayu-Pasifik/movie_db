import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/models/ReviewMovie.dart';
import 'package:movie_db/app/modules/DetailPage/controllers/detail_page_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReviewItemsView extends GetView<DetailPageController> {
  final String id;
  const ReviewItemsView({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<DetailPageController>(
      builder: (c) {
        return GetBuilder<DetailPageController>(
          builder: (c) {
            return SmartRefresher(
                controller: c.reviewRefresh,
                enablePullDown: true,
                enablePullUp: true,
                onLoading: () => c.loadData(this.id),
                onRefresh: () => c.refreshData(this.id),
                child: (c.reviews.isNotEmpty)
                    ? ListView.builder(
                        itemCount: c.reviews.length,
                        itemBuilder: (context, index) {
                          ReviewMovie reviewMovie = c.reviews[index];
                          return (reviewMovie.authorDetails!.avatarPath != null)
                              ? ListTile(
                                  isThreeLine: true,
                                  leading: (reviewMovie
                                          .authorDetails!.avatarPath!
                                          .contains("https://www.gravatar.com"))
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "${reviewMovie.authorDetails!.avatarPath!.replaceFirst("/", "")}"),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://www.gravatar.com/avatar${reviewMovie.authorDetails!.avatarPath}")),
                                  title: Text("${reviewMovie.author}"),
                                  subtitle: Text("${reviewMovie.content}"),
                                )
                              : Center(
                                  child: Text("No Data Review..."),
                                );
                        },
                      )
                    : Center(
                        child: Text("There is no Review"),
                      ));
          },
        );
      },
    ));
  }
}
