import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<SearchController>(
        builder: (c) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                TextField(
                  focusNode: FocusNode(canRequestFocus: false),
                  autofocus: false,
                  controller: c.searchController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: 'Search Movie',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: (() {
                        c.resultSearch.clear();
                        c.searchMovie(c.searchController.text, c.hal.string);
                        print(c.searchController.text);
                      }),
                      child: const Text("Search")),
                ),
                Container(
                  width: context.width,
                  height: context.height,
                  // color: Colors.amber,
                  child: SmartRefresher(
                      controller: c.searchRefresh,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () => c.refreshData(),
                      onLoading: () => c.loadData(),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: c.resultSearch.length,
                        itemBuilder: (context, index) {
                          CurrentMovie movie = c.resultSearch[index];
                          return FutureBuilder(
                            future: c.detailMovie(movie.id.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("${snapshot.error}"),
                                );
                              } else if (snapshot.hasData) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Material(
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(8),
                                    child: GestureDetector(
                                      onTap: () => Get.toNamed(
                                          Routes.DETAIL_PAGE,
                                          arguments: movie),
                                      child: Row(
                                        children: [
                                          // ! image on the left
                                          Container(
                                            width: 100,
                                            height: 150,
                                            child: (movie.posterPath != null)
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        "https://image.tmdb.org/t/p/original${snapshot.data?.posterPath}",
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Center(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/Image_not_available.png"),
                                                  )
                                                : Image.asset(
                                                    "assets/images/Image_not_available.png"),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: context.width,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[100],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "${movie.title}",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(CupertinoIcons
                                                              .star),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            "${movie.voteAverage}",
                                                            style: GoogleFonts
                                                                .poppins(),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(CupertinoIcons
                                                              .calendar),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          (movie.releaseDate !=
                                                                  null)
                                                              ? Text(
                                                                  "${movie.releaseDate?.year}",
                                                                  style: GoogleFonts
                                                                      .poppins(),
                                                                )
                                                              : Text(
                                                                  "Null",
                                                                  style: GoogleFonts
                                                                      .poppins(),
                                                                )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(CupertinoIcons
                                                              .clock),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          (snapshot.data?.runtime !=
                                                                      null ||
                                                                  snapshot.data
                                                                          ?.runtime !=
                                                                      0)
                                                              ? Text(
                                                                  "${snapshot.data?.runtime} Minutes",
                                                                  style: GoogleFonts
                                                                      .poppins(),
                                                                )
                                                              : Text(
                                                                  "Null",
                                                                  style: GoogleFonts
                                                                      .poppins(),
                                                                )
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }
                              return Center(
                                child: Text("No Data"),
                              );
                            },
                          );
                        },
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
