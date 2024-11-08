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

  factory UserAccount.fromMap(Map<String, dynamic> data) {
    return UserAccount(
      id: data['id'] as String,
      name: data['name'] as String,
      address: data['address'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      email: data['email'] as String,
      provider: data['provider'] as String?,
      profileImg: data['profileImg'] as String?,
      description: data['description'] as String?,
      validId: data['validId'] as String?,
      role: data['role'] as String,
      onlineStatus: data['onlineStatus'] as bool?,
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'] as String)
          : null,
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
