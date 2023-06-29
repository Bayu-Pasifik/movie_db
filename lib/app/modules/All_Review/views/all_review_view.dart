import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/DetailMovie.dart';
import 'package:movie_db/app/data/models/ReviewMovie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/all_review_controller.dart';

class AllReviewView extends GetView<AllReviewController> {
  const AllReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DetailMovie detailMovie = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "All Reviews for ${detailMovie.title}",
            style: GoogleFonts.poppins(),
          ),
        ),
        body: GetBuilder<AllReviewController>(
          builder: (c) {
            return GetBuilder<AllReviewController>(
              builder: (c) {
                return SmartRefresher(
                    controller: c.reviewRefresh,
                    enablePullDown: true,
                    enablePullUp: true,
                    onLoading: () => c.loadData(detailMovie.id.toString()),
                    onRefresh: () => c.refreshData(detailMovie.id.toString()),
                    child: (c.reviews.isNotEmpty)
                        ? ListView.builder(
                            itemCount: controller.reviews.length,
                            itemBuilder: (context, index) {
                              ReviewMovie reviewMovie = c.reviews[index];
                              return ListTile(
                                isThreeLine: true,
                                leading: (reviewMovie
                                            .authorDetails!.avatarPath !=
                                        null)
                                    ? (reviewMovie.authorDetails!.avatarPath!
                                            .contains(
                                                "https://www.gravatar.com"))
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
                              "There Is No Data Review",
                              style: GoogleFonts.poppins(),
                            ),
                          ));
              },
            );
          },
        ));
  }
}
