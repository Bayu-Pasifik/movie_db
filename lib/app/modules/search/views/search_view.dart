import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_db/app/data/models/CurrentMovie.dart';
import 'package:movie_db/app/routes/app_pages.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchC> {
  final String? userData;
  final controller = Get.put(SearchC());

  SearchView({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            TextField(
              focusNode: FocusNode(canRequestFocus: false),
              autofocus: false,
              controller: controller.searchController,
              decoration: InputDecoration(
                labelText: "Search",
                hintText: 'Search Movie',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  controller.searchMovie(controller.searchController.text,
                      controller.searchMovieController.firstPageKey);
                },
                child: const Text("Search"),
              ),
            ),
            Expanded(
              child: PagedListView<int, CurrentMovie>.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                pagingController: controller.searchMovieController,
                builderDelegate: PagedChildBuilderDelegate<CurrentMovie>(
                  animateTransitions: true,
                  itemBuilder: (context, item, index) => GestureDetector(
                      child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.DETAIL_PAGE,
                              arguments: {"movie": item, "user": userData}),
                          child: Row(children: [
                            // ! image left
                            Container(
                              width: 100,
                              height: 150,
                              child: (item.posterPath != null)
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/original${item.posterPath}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/images/Image_not_available.png"),
                                    )
                                  : Image.asset(
                                      "assets/images/Image_not_available.png"),
                            ),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: context.width,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${item.title}",
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
                                                  Icon(CupertinoIcons.star),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "${item.voteAverage}",
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(CupertinoIcons.calendar),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  (item.releaseDate != null)
                                                      ? Text(
                                                          "${item.releaseDate?.year}",
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
                                            ],
                                          ),
                                        ))))
                          ]))),
                  firstPageErrorIndicatorBuilder: (_) {
                    return Center(
                      child: Text(
                        "${controller.searchMovieController.error}",
                      ),
                    );
                  },
                  newPageErrorIndicatorBuilder: (context) =>
                      Text("${controller.searchMovieController.error}"),
                  firstPageProgressIndicatorBuilder: (context) => Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                      color: const Color(0XFF54BAB9),
                      size: 50,
                    ),
                  ),
                  transitionDuration: const Duration(seconds: 1),
                  newPageProgressIndicatorBuilder: (context) => Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: const Color(0XFF54BAB9),
                      size: 50,
                    ),
                  ),
                  noItemsFoundIndicatorBuilder: (_) {
                    return const Center(
                      child: Text('No data found'),
                    );
                  },
                  noMoreItemsIndicatorBuilder: (_) {
                    return const Center(
                      child: Text('No data found'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
