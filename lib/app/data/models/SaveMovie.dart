import 'package:cloud_firestore/cloud_firestore.dart';


class SaveMovie {
  final String? id;
  final String name;
  final String rating;
  final String imageUrl;
  final String createdAt;
  // final String madeBy;

   SaveMovie({
    this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.createdAt,
    // required this.madeBy
  });

  Map<String, dynamic> toJason() {
    return {
      "Name": name,
      "Rating": rating,
      "ImageUrl": imageUrl,
      "CreatedAt": createdAt,
      // "MadeBy": madeBy,
    };
  }

  factory SaveMovie.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data = document.data()!;
     return SaveMovie(
      id: document.id,
      name: data["Name"], 
      rating: data["Rating"], 
      imageUrl: data["ImageUrl"], 
      createdAt: data["CreatedAt"]);
  }
}
