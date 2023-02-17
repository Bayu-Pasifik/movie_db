class SaveMovie {
  final String name;
  final String rating;
  final String imageUrl;
  final String createdAt;
  // final String madeBy;

  const SaveMovie({
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
}
