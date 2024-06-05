// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  bool? success;
  List<Datum>? data;
  String? message;

  StateModel({
    this.success,
    this.data,
    this.message,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  int? id;
  String? name;
  int? countryId;
  CountryCode? countryCode;
  String? fipsCode;
  String? iso2;
  Type? type;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? flag;
  String? wikiDataId;

  Datum({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.fipsCode,
    this.iso2,
    this.type,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.flag,
    this.wikiDataId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    countryCode: countryCodeValues.map[json["country_code"]],
    fipsCode: json["fips_code"],
    iso2: json["iso2"],
    type: typeValues.map[json["type"]],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    flag: json["flag"],
    wikiDataId: json["wikiDataId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "country_code": countryCodeValues.reverse[countryCode],
    "fips_code": fipsCode,
    "iso2": iso2,
    "type": typeValues.reverse[type],
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "flag": flag,
    "wikiDataId": wikiDataId,
  };
}

enum CountryCode {
  IN
}

final countryCodeValues = EnumValues({
  "IN": CountryCode.IN
});

enum Type {
  STATE,
  UNION_TERRITORY
}

final typeValues = EnumValues({
  "state": Type.STATE,
  "Union territory": Type.UNION_TERRITORY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
