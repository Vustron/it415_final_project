class UserAccount {
  UserAccount({
    required this.id,
    required this.name,
    this.address,
    this.phoneNumber,
    required this.email,
    this.provider,
    this.profileImg,
    this.description,
    this.validId,
    required this.role,
    this.onlineStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String,
      provider: json['provider'] as String?,
      profileImg: json['profileImg'] as String?,
      description: json['description'] as String?,
      validId: json['validId'] as String?,
      role: json['role'] as String,
      onlineStatus: json['onlineStatus'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'provider': provider,
      'profileImg': profileImg,
      'description': description,
      'validId': validId,
      'role': role,
      'onlineStatus': onlineStatus,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  final String id;
  final String name;
  final String? address;
  final String? phoneNumber;
  final String email;
  final String? provider;
  final String? profileImg;
  final String? description;
  final String? validId;
  final String role;
  final bool? onlineStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
