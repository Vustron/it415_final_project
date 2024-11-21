class BabysitterRatings {
  BabysitterRatings({
    required this.id,
    required this.babysitterId,
    required this.clientId,
    required this.rating,
    required this.review,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BabysitterRatings.fromMap(Map<String, dynamic> data) {
    return BabysitterRatings(
      id: data['id'] as String,
      babysitterId: data['babysitterId'] as String,
      clientId: data['clientId'] as String,
      rating: data['rating'] as int,
      review: data['review'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
    );
  }

  final String id;
  final String babysitterId;
  final String clientId;
  final int rating;
  final String review;
  final DateTime createdAt;
  final DateTime updatedAt;
}
