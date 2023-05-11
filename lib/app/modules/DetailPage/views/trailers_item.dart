import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/data/models/TrailerModel.dart';
import 'package:movie_db/app/modules/DetailPage/controllers/detail_page_controller.dart';
import 'package:movie_db/app/modules/DetailPage/views/video_item.dart';

class TrailersItem extends GetView<DetailPageController> {
  final int id;
  const TrailersItem({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.trailersMovie(this.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
          }
          return (controller.trailers != 0)
              ? ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 20),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    TrailerModel trailers = controller.trailers[index];
                    var trailer = trailers.type == "Trailer";
                    print("Count : ${trailer}");
                    return Container(
                      height: 200,
                      width: 300,
                      color: Colors.amber,
                      child: VideoItem(
                          url: (trailers.official = true)
                              ? trailers.key!
                              : "null"),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                )
              : Center(
                  child: Text("There is no Trailers"),
                );
        });
  }
}
