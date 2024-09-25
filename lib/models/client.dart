import 'babysitter.dart';

class Client {
  Client({
    required this.id,
    required this.clientId,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.provider,
    required this.profileImg,
    required this.onlineStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Client.fromMap(Map<String, dynamic> data) {
    return Client(
      id: data['id'] as String,
      clientId: data['clientId'] as String,
      name: data['name'] as String,
      address: data['address'] as String,
      phoneNumber: data['phoneNumber'] as String,
      email: data['email'] as String,
      provider: Provider.values.firstWhere(
          (Provider e) => e.toString().split('.').last == data['provider']),
      profileImg: data['profileImg'] as String,
      onlineStatus: data['onlineStatus'] as bool,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
    );
  }

  String id;
  String clientId;
  String name;
  String address;
  String phoneNumber;
  String email;
  Provider provider;
  String profileImg;
  bool onlineStatus;
  DateTime createdAt;
  DateTime updatedAt;
}
