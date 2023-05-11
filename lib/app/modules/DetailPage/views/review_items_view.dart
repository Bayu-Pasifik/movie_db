import 'package:expandable/expandable.dart';
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
    return Scaffold(
        body: FutureBuilder(
      future: controller.reviewMovie(id, controller.hal.toInt()),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            ReviewMovie reviewMovie = controller.reviews[index];
            return ExpandablePanel(
              header: Text(reviewMovie.author ?? "Null",
                  style: GoogleFonts.poppins()),
              collapsed: Row(
                children: [
                  (reviewMovie.authorDetails!.avatarPath != null)
                      ? (reviewMovie.authorDetails!.avatarPath!
                              .contains("https://www.gravatar.com"))
                          ? Container(
                              width: 70,
                              height: 70,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${reviewMovie.authorDetails!.avatarPath!.replaceFirst("/", "")}"),
                                  ),
                                  Text(
                                    "${reviewMovie.authorDetails!.rating}",
                                    style: GoogleFonts.poppins(),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: 70,
                              height: 70,
                              child: Column(
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
                              ),
                            )
                      : Container(
                          width: 100,
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
                  Expanded(
                    child: Text(
                      reviewMovie.content ?? "Null",
                      softWrap: true,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ],
              ),
              expanded: Row(
                children: [
                  (reviewMovie.authorDetails!.avatarPath != null)
                      ? (reviewMovie.authorDetails!.avatarPath!
                              .contains("https://www.gravatar.com"))
                          ? Container(
                              width: 70,
                              height: 70,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${reviewMovie.authorDetails!.avatarPath!.replaceFirst("/", "")}"),
                                  ),
                                  Text(
                                    "${reviewMovie.authorDetails!.rating}",
                                    style: GoogleFonts.poppins(),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: 70,
                              height: 70,
                              child: Column(
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
                              ),
                            )
                      : Container(
                          width: 100,
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
                  Expanded(
                    child: Text(
                      reviewMovie.content ?? "Null",
                      softWrap: true,
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 1,
        );
      },
    ));
  }
}
