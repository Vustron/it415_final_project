class UserAccount {
  const UserAccount({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.email,
    this.provider,
    this.profileImg,
    this.description,
    this.validId,
    this.role,
    this.birthDate,
    this.gender,
    this.onlineStatus,
    this.emailVerified,
    this.validIdVerified,
    this.validIdFront,
    this.validIdBack,
    this.createdAt,
    this.updatedAt,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        id: json['id'] as String?,
        name: json['name'] as String?,
        address: json['address'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        email: json['email'] as String?,
        provider: json['provider'] as String?,
        profileImg: json['profileImg'] as String?,
        description: json['description'] as String?,
        validId: json['validId'] as String?,
        role: json['role'] as String?,
        birthDate: json['birthDate'] != null
            ? DateTime.parse(json['birthDate'] as String)
            : null,
        gender: json['gender'] as String?,
        onlineStatus: json['onlineStatus'] as bool?,
        emailVerified: json['emailVerified'] != null &&
                json['emailVerified'].toString().isNotEmpty &&
                json['emailVerified'] != ''
            ? DateTime.parse(json['emailVerified'] as String)
            : null,
        validIdVerified: json['validIdVerified'] != null &&
                json['validIdVerified'].toString().isNotEmpty &&
                json['validIdVerified'] != ''
            ? DateTime.parse(json['validIdVerified'] as String)
            : null,
        validIdFront: json['validIdFront'] as String?,
        validIdBack: json['validIdBack'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
      );

  final String? id;
  final String? name;
  final String? address;
  final String? phoneNumber;
  final String? email;
  final String? provider;
  final String? profileImg;
  final String? description;
  final String? validId;
  final String? role;
  final DateTime? birthDate;
  final String? gender;
  final bool? onlineStatus;
  final DateTime? emailVerified;
  final DateTime? validIdVerified;
  final String? validIdFront;
  final String? validIdBack;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
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
        'birthDate': birthDate?.toIso8601String(),
        'gender': gender,
        'onlineStatus': onlineStatus,
        'emailVerified': emailVerified?.toIso8601String(),
        'validIdVerified': validIdVerified?.toIso8601String(),
        'validIdFront': validIdFront,
        'validIdBack': validIdBack,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  UserAccount copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? phoneNumber,
    String? address,
    String? profileImg,
    String? description,
    String? validId,
    DateTime? birthDate,
    String? gender,
    bool? onlineStatus,
    String? provider,
    DateTime? emailVerified,
    DateTime? validIdVerified,
    String? validIdFront,
    String? validIdBack,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserAccount(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profileImg: profileImg ?? this.profileImg,
      description: description ?? this.description,
      validId: validId ?? this.validId,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      provider: provider ?? this.provider,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      emailVerified: emailVerified ?? this.emailVerified,
      validIdVerified: validIdVerified ?? this.validIdVerified,
      validIdFront: validIdFront ?? this.validIdFront,
      validIdBack: validIdBack ?? this.validIdBack,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
