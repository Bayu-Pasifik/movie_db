import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_db/app/data/models/GenreMovie.dart';
import 'package:movie_db/app/routes/app_pages.dart';

import '../controllers/list_genre_controller.dart';

class ListGenreView extends GetView<ListGenreController> {
  final String? userData;
  const ListGenreView({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List>(
          future: controller.genres,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.separated(
                  itemCount: controller.allGenre.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    GenreMovie genreMovie = controller.allGenre[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.GENRE_RESULT,
                            arguments: {"movie": genreMovie, "user": userData});
                      },
                      child: Material(
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(child: Text("${index + 1}")),
                          title: Text("${genreMovie.name}"),
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return Center(
              child: Text("Loading....."),
            );
          },
        ),
      ),
    );
  }
}
