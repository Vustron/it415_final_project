class AddressAPI {
  AddressAPI({
    this.amenity,
    this.road,
    this.neighbourhood,
    this.suburb,
    this.city,
    this.state,
    this.iso31662lvl4,
    this.region,
    this.iso31662lvl3,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory AddressAPI.fromJson(Map<String, dynamic> json) {
    return AddressAPI(
      amenity: json['amenity'] as String?,
      road: json['road'] as String?,
      neighbourhood: json['neighbourhood'] as String?,
      suburb: json['suburb'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      iso31662lvl4: json['ISO3166-2-lvl4'] as String?,
      region: json['region'] as String?,
      iso31662lvl3: json['ISO3166-2-lvl3'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
      countryCode: json['country_code'] as String?,
    );
  }

  final String? amenity;
  final String? road;
  final String? neighbourhood;
  final String? suburb;
  final String? city;
  final String? state;
  final String? iso31662lvl4;
  final String? region;
  final String? iso31662lvl3;
  final String? postcode;
  final String? country;
  final String? countryCode;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'amenity': amenity,
      'road': road,
      'neighbourhood': neighbourhood,
      'suburb': suburb,
      'city': city,
      'state': state,
      'ISO3166-2-lvl4': iso31662lvl4,
      'region': region,
      'ISO3166-2-lvl3': iso31662lvl3,
      'postcode': postcode,
      'country': country,
      'country_code': countryCode,
    };
  }

  AddressAPI copyWith({
    String? amenity,
    String? road,
    String? neighbourhood,
    String? suburb,
    String? city,
    String? state,
    String? iso31662lvl4,
    String? region,
    String? iso31662lvl3,
    String? postcode,
    String? country,
    String? countryCode,
  }) {
    return AddressAPI(
      amenity: amenity ?? this.amenity,
      road: road ?? this.road,
      neighbourhood: neighbourhood ?? this.neighbourhood,
      suburb: suburb ?? this.suburb,
      city: city ?? this.city,
      state: state ?? this.state,
      iso31662lvl4: iso31662lvl4 ?? this.iso31662lvl4,
      region: region ?? this.region,
      iso31662lvl3: iso31662lvl3 ?? this.iso31662lvl3,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}
