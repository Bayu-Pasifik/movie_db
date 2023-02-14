import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                          return ListTile(
                            isThreeLine: true,
                            leading: (reviewMovie.authorDetails!.avatarPath !=
                                    null)
                                ? (reviewMovie.authorDetails!.avatarPath!
                                        .contains("https://www.gravatar.com"))
                                    ? Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "${reviewMovie.authorDetails!.avatarPath!.replaceFirst("/", "")}"),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${reviewMovie.authorDetails!.rating}",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://www.gravatar.com/avatar${reviewMovie.authorDetails!.avatarPath}")),
                                          Expanded(
                                            child: Text(
                                              "${reviewMovie.authorDetails!.rating}",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          )
                                        ],
                                      )
                                : Container(
                                    width: 50,
                                    height: 100,
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/Image_not_available.png"),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${reviewMovie.authorDetails!.rating}",
                                            style: GoogleFonts.poppins(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            title: Text(
                              "${reviewMovie.author}",
                              style: GoogleFonts.poppins(),
                            ),
                            subtitle: Text(
                              "${reviewMovie.content}",
                              style: GoogleFonts.poppins(),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "There is no Review",
                          style: GoogleFonts.montserrat(),
                        ),
                      ));
          },
        );
      },
    ));
  }
}
