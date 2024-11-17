enum Status {
  pending,
  finished,
  cancelled,
}

class Booking {
  Booking({
    required this.id,
    required this.clientId,
    required this.babysitterId,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.status,
    required this.totalCharge,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromMap(Map<String, dynamic> data) {
    return Booking(
      id: data['id'] as String,
      clientId: data['clientId'] as String,
      babysitterId: data['babysitterId'] as String,
      address: data['address'] as String,
      longitude: data['longitude'] as String,
      latitude: data['latitude'] as String,
      status: Status.values.firstWhere(
          (Status e) => e.toString().split('.').last == data['status']),
      totalCharge: data['totalCharge'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
    );
  }

  String id;
  String clientId;
  String babysitterId;
  String address;
  String longitude;
  String latitude;
  Status status;
  String totalCharge;
  DateTime createdAt;
  DateTime updatedAt;
}
