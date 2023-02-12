// To parse this JSON data, do
//
//     final genreMovie = genreMovieFromJson(jsonString);

import 'dart:convert';

GenreMovie genreMovieFromJson(String str) => GenreMovie.fromJson(json.decode(str));

String genreMovieToJson(GenreMovie data) => json.encode(data.toJson());

class GenreMovie {
    GenreMovie({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory GenreMovie.fromJson(Map<String, dynamic> json) => GenreMovie(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
