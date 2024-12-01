class UserAccount {
  const UserAccount({
    this.id,
    this.name,
    this.address,
    this.addressLatitude,
    this.addressLongitude,
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
    this.hourlyRate,
    this.babysittingExperience,
    this.experienceWithAges,
    this.hasDrivingLicense,
    this.hasCar,
    this.hasChildren,
    this.isSmoker,
    this.preferredBabysittingLocation,
    this.languagesSpeak,
    this.comfortableWith,
    this.availability,
    this.createdAt,
    this.updatedAt,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        id: json['id'] as String?,
        name: json['name'] as String?,
        address: json['address'] as String?,
        addressLatitude: json['addressLatitude'] as String?,
        addressLongitude: json['addressLongitude'] as String?,
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
        hourlyRate: json['hourlyRate'] as String?,
        babysittingExperience: json['babysittingExperience'] as String?,
        experienceWithAges: (json['experienceWithAges'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList(),
        hasDrivingLicense: json['hasDrivingLicense'] as bool?,
        hasCar: json['hasCar'] as bool?,
        hasChildren: json['hasChildren'] as bool?,
        isSmoker: json['isSmoker'] as bool?,
        preferredBabysittingLocation:
            (json['preferredBabysittingLocation'] as List<dynamic>?)
                ?.map((dynamic e) => e as String)
                .toList(),
        languagesSpeak: (json['languagesSpeak'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList(),
        comfortableWith: (json['comfortableWith'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList(),
        availability: (json['availability'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList(),
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
  final String? addressLatitude;
  final String? addressLongitude;
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
  final String? hourlyRate;
  final String? babysittingExperience;
  final List<String>? experienceWithAges;
  final bool? hasDrivingLicense;
  final bool? hasCar;
  final bool? hasChildren;
  final bool? isSmoker;
  final List<String>? preferredBabysittingLocation;
  final List<String>? languagesSpeak;
  final List<String>? comfortableWith;
  final List<String>? availability;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'address': address,
        'addressLatitude': addressLatitude,
        'addressLongitude': addressLongitude,
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
        'hourlyRate': hourlyRate,
        'babysittingExperience': babysittingExperience,
        'experienceWithAges': experienceWithAges,
        'hasDrivingLicense': hasDrivingLicense,
        'hasCar': hasCar,
        'hasChildren': hasChildren,
        'isSmoker': isSmoker,
        'preferredBabysittingLocation': preferredBabysittingLocation,
        'languagesSpeak': languagesSpeak,
        'comfortableWith': comfortableWith,
        'availability': availability,
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
    String? addressLatitude,
    String? addressLongitude,
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
    String? hourlyRate,
    String? babysittingExperience,
    List<String>? experienceWithAges,
    bool? hasDrivingLicense,
    bool? hasCar,
    bool? hasChildren,
    bool? isSmoker,
    List<String>? preferredBabysittingLocation,
    List<String>? languagesSpeak,
    List<String>? comfortableWith,
    List<String>? availability,
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
      addressLatitude: addressLatitude ?? this.addressLatitude,
      addressLongitude: addressLongitude ?? this.addressLongitude,
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
      hourlyRate: hourlyRate ?? this.hourlyRate,
      babysittingExperience:
          babysittingExperience ?? this.babysittingExperience,
      experienceWithAges: experienceWithAges ?? this.experienceWithAges,
      hasDrivingLicense: hasDrivingLicense ?? this.hasDrivingLicense,
      hasCar: hasCar ?? this.hasCar,
      hasChildren: hasChildren ?? this.hasChildren,
      isSmoker: isSmoker ?? this.isSmoker,
      preferredBabysittingLocation:
          preferredBabysittingLocation ?? this.preferredBabysittingLocation,
      languagesSpeak: languagesSpeak ?? this.languagesSpeak,
      comfortableWith: comfortableWith ?? this.comfortableWith,
      availability: availability ?? this.availability,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
