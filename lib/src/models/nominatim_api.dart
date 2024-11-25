class NominatimAPI {
  NominatimAPI({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.placeClass,
    required this.type,
    required this.placeRank,
    required this.importance,
    required this.addressType,
    required this.name,
    required this.displayName,
    required this.address,
    required this.boundingBox,
  });

  factory NominatimAPI.fromJson(Map<String, dynamic> json) {
    return NominatimAPI(
      placeId: json['place_id'] as int,
      licence: json['licence'] as String,
      osmType: json['osm_type'] as String,
      osmId: json['osm_id'] as int,
      lat: json['lat'] as String,
      lon: json['lon'] as String,
      placeClass: json['class'] as String,
      type: json['type'] as String,
      placeRank: json['place_rank'] as int,
      importance: (json['importance'] as num).toDouble(),
      addressType: json['addresstype'] as String,
      name: json['name'] as String,
      displayName: json['display_name'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      boundingBox: (json['boundingbox'] as List<dynamic>)
          .map((dynamic e) => e.toString())
          .toList(),
    );
  }

  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final String lat;
  final String lon;
  final String placeClass;
  final String type;
  final int placeRank;
  final double importance;
  final String addressType;
  final String name;
  final String displayName;
  final Address address;
  final List<String> boundingBox;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'place_id': placeId,
        'licence': licence,
        'osm_type': osmType,
        'osm_id': osmId,
        'lat': lat,
        'lon': lon,
        'class': placeClass,
        'type': type,
        'place_rank': placeRank,
        'importance': importance,
        'addresstype': addressType,
        'name': name,
        'display_name': displayName,
        'address': address.toJson(),
        'boundingbox': boundingBox,
      };

  NominatimAPI copyWith({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    String? lat,
    String? lon,
    String? placeClass,
    String? type,
    int? placeRank,
    double? importance,
    String? addressType,
    String? name,
    String? displayName,
    Address? address,
    List<String>? boundingBox,
  }) {
    return NominatimAPI(
      placeId: placeId ?? this.placeId,
      licence: licence ?? this.licence,
      osmType: osmType ?? this.osmType,
      osmId: osmId ?? this.osmId,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      placeClass: placeClass ?? this.placeClass,
      type: type ?? this.type,
      placeRank: placeRank ?? this.placeRank,
      importance: importance ?? this.importance,
      addressType: addressType ?? this.addressType,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      address: address ?? this.address,
      boundingBox: boundingBox ?? this.boundingBox,
    );
  }
}

class Address {
  Address({
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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
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

  Address copyWith({
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
    return Address(
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
