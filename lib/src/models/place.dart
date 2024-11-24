import 'package:babysitterapp/src/models.dart';

class PlaceAPI {
  PlaceAPI({
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

  factory PlaceAPI.fromJson(Map<String, dynamic> json) {
    return PlaceAPI(
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
      address: AddressAPI.fromJson(json['address'] as Map<String, dynamic>),
      boundingBox: List<String>.from(json['boundingbox'] as List<String>),
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
  final AddressAPI address;
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

  PlaceAPI copyWith({
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
    AddressAPI? address,
    List<String>? boundingBox,
  }) {
    return PlaceAPI(
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
