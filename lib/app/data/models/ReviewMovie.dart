// To parse this JSON data, do
//
//     final reviewMovie = reviewMovieFromJson(jsonString);

import 'dart:convert';

ReviewMovie reviewMovieFromJson(String str) =>
    ReviewMovie.fromJson(json.decode(str));

String reviewMovieToJson(ReviewMovie data) => json.encode(data.toJson());

class ReviewMovie {
  ReviewMovie({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  String? author;
  AuthorDetails? authorDetails;
  String? content;
  DateTime? createdAt;
  String? id;
  DateTime? updatedAt;
  String? url;

  factory ReviewMovie.fromJson(Map<String, dynamic> json) => ReviewMovie(
        author: json["author"],
        authorDetails: json["author_details"] == null
            ? null
            : AuthorDetails.fromJson(json["author_details"]),
        content: json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "author_details": authorDetails?.toJson(),
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "url": url,
      };
}

class AuthorDetails {
  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  String? name;
  String? username;
  String? avatarPath;
  double? rating;

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"],
        username: json["username"],
        avatarPath: json["avatar_path"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
        "rating": rating,
      };
}
