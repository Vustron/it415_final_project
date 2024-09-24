// models
import 'ratings.dart';
import 'booking.dart';

enum Provider {
  google,
  facebook,
}

class Babysitter {
  Babysitter({
    required this.id,
    required this.babysitterId,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.provider,
    required this.profileImg,
    required this.description,
    required this.experience,
    required this.certificates,
    required this.resume,
    required this.validId,
    required this.ratingsPerHour,
    required this.ratings,
    required this.onlineStatus,
    required this.booking,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Babysitter.fromMap(Map<String, dynamic> data) {
    return Babysitter(
      id: data['id'] as String,
      babysitterId: data['babysitterId'] as String,
      name: data['name'] as String,
      address: data['address'] as String,
      phoneNumber: data['phoneNumber'] as String,
      email: data['email'] as String,
      provider: Provider.values.firstWhere(
          (Provider e) => e.toString().split('.').last == data['provider']),
      profileImg: data['profileImg'] as String,
      description: data['description'] as String,
      experience: data['experience'] as String,
      certificates: data['certificates'] as String,
      resume: data['resume'] as String,
      validId: data['validId'] as String,
      ratingsPerHour: data['ratingsPerHour'] as String,
      ratings: Ratings.fromMap(data['ratings'] as Map<String, dynamic>),
      booking: Booking.fromMap(data['booking'] as Map<String, dynamic>),
      onlineStatus: data['onlineStatus'] as bool,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
    );
  }

  final String id;
  final String babysitterId;
  final String name;
  final String address;
  final String phoneNumber;
  final String email;
  final Provider provider;
  final String profileImg;
  final String description;
  final String experience;
  final String certificates;
  final String resume;
  final String validId;
  final String ratingsPerHour;
  final Ratings ratings;
  final Booking booking;
  final bool onlineStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
}
