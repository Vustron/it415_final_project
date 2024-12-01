class Booking {
  Booking({
    this.id,
    required this.parentId,
    required this.babysitterId,
    required this.numberOfChildren,
    required this.stayIn,
    required this.workingDate,
    required this.address,
    required this.addressLatitude,
    required this.addressLongitude,
    required this.startTime,
    required this.endTime,
    required this.details,
    required this.totalCost,
    this.status = 'pending',
    this.paymentStatus = 'pending',
    this.paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String?,
      parentId: json['parentId'] as String,
      babysitterId: json['babysitterId'] as String,
      numberOfChildren: json['numberOfChildren'] as int,
      stayIn: json['stayIn'] as bool,
      workingDate: DateTime.parse(json['workingDate'] as String),
      address: json['address'] as String,
      addressLatitude: json['addressLatitude'] as String,
      addressLongitude: json['addressLongitude'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      details: json['details'] as String,
      totalCost: json['totalCost'] as String,
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentMethod: json['paymentMethod'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  final String? id;
  final String parentId;
  final String babysitterId;
  final int numberOfChildren;
  final bool stayIn;
  final DateTime workingDate;
  final String address;
  final String addressLatitude;
  final String addressLongitude;
  final String startTime;
  final String endTime;
  final String details;
  final String totalCost;
  final String status;
  final String paymentStatus;
  final String? paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking copyWith({
    String? id,
    String? parentId,
    String? babysitterId,
    int? numberOfChildren,
    bool? stayIn,
    DateTime? startDate,
    DateTime? endDate,
    String? address,
    String? addressLatitude,
    String? addressLongitude,
    String? startTime,
    String? endTime,
    String? details,
    String? totalCost,
    String? status,
    String? paymentStatus,
    String? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      babysitterId: babysitterId ?? this.babysitterId,
      numberOfChildren: numberOfChildren ?? this.numberOfChildren,
      stayIn: stayIn ?? this.stayIn,
      workingDate: workingDate,
      address: address ?? this.address,
      addressLatitude: addressLatitude ?? this.addressLatitude,
      addressLongitude: addressLongitude ?? this.addressLongitude,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      details: details ?? this.details,
      totalCost: totalCost ?? this.totalCost,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'parentId': parentId,
      'babysitterId': babysitterId,
      'numberOfChildren': numberOfChildren,
      'stayIn': stayIn,
      'workingDate': workingDate.toIso8601String(),
      'address': address,
      'addressLatitude': addressLatitude,
      'addressLongitude': addressLongitude,
      'startTime': startTime,
      'endTime': endTime,
      'details': details,
      'totalCost': totalCost,
      'status': status,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
