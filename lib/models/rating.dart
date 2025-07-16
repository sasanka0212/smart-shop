import 'dart:convert';

class Rating {
  final String userId;
  final double rating;

  Rating({required this.userId, required this.rating});

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'rating': rating};
  }

  factory Rating.fromMap(Map<String, dynamic> data) {
    return Rating(
      userId: data['userId'] ?? '',
      rating: data['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
