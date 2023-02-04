import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/app/modules/home/controllers/now_playing_controller_controller.dart';
import 'package:movie_db/app/modules/home/controllers/upcoming_controller_controller.dart';
import 'package:movie_db/app/modules/home/views/now_playing_view.dart';
import 'package:movie_db/app/modules/home/views/upcoming_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<UpcomingControllerController>();
    Get.find<NowPlayingControllerController>();
    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What do you want to watch ?",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        width: 50,
                        color: Colors.black45,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(isScrollable: true, labelColor: Colors.black, tabs: [
                Tab(
                  text: "Currently Airing",
                ),
                Tab(
                  text: "Upcoming",
                ),
                Tab(
                  text: "Top Rated",
                ),
                Tab(
                  text: "Popular",
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TabBarView(children: [
                  NowPlayingView(),
                  UpcomingView(),
                  Text("top rated"),
                  Text("popular"),
                ]),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
