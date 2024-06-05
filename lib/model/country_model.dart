// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  bool? success;
  List<Datum>? data;
  String? message;

  CountryModel({
    this.success,
    this.data,
    this.message,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
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
  String? iso3;
  String? numericCode;
  String? iso2;
  String? phonecode;
  String? capital;
  String? currency;
  String? currencyName;
  String? currencySymbol;
  String? tld;
  String? native;
  Region? region;
  int? regionId;
  String? subregion;
  int? subregionId;
  String? nationality;
  String? timezones;
  String? translations;
  String? latitude;
  String? longitude;
  String? emoji;
  String? emojiU;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? flag;
  String? wikiDataId;

  Datum({
    this.id,
    this.name,
    this.iso3,
    this.numericCode,
    this.iso2,
    this.phonecode,
    this.capital,
    this.currency,
    this.currencyName,
    this.currencySymbol,
    this.tld,
    this.native,
    this.region,
    this.regionId,
    this.subregion,
    this.subregionId,
    this.nationality,
    this.timezones,
    this.translations,
    this.latitude,
    this.longitude,
    this.emoji,
    this.emojiU,
    this.createdAt,
    this.updatedAt,
    this.flag,
    this.wikiDataId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    iso3: json["iso3"],
    numericCode: json["numeric_code"],
    iso2: json["iso2"],
    phonecode: json["phonecode"],
    capital: json["capital"],
    currency: json["currency"],
    currencyName: json["currency_name"],
    currencySymbol: json["currency_symbol"],
    tld: json["tld"],
    native: json["native"],
    region: regionValues.map[json["region"]]!,
    regionId: json["region_id"],
    subregion: json["subregion"],
    subregionId: json["subregion_id"],
    nationality: json["nationality"],
    timezones: json["timezones"],
    translations: json["translations"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    emoji: json["emoji"],
    emojiU: json["emojiU"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    flag: json["flag"],
    wikiDataId: json["wikiDataId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "iso3": iso3,
    "numeric_code": numericCode,
    "iso2": iso2,
    "phonecode": phonecode,
    "capital": capital,
    "currency": currency,
    "currency_name": currencyName,
    "currency_symbol": currencySymbol,
    "tld": tld,
    "native": native,
    "region": regionValues.reverse[region],
    "region_id": regionId,
    "subregion": subregion,
    "subregion_id": subregionId,
    "nationality": nationality,
    "timezones": timezones,
    "translations": translations,
    "latitude": latitude,
    "longitude": longitude,
    "emoji": emoji,
    "emojiU": emojiU,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "flag": flag,
    "wikiDataId": wikiDataId,
  };
}

enum Region {
  AFRICA,
  AMERICAS,
  ASIA,
  EMPTY,
  EUROPE,
  OCEANIA,
  POLAR
}

final regionValues = EnumValues({
  "Africa": Region.AFRICA,
  "Americas": Region.AMERICAS,
  "Asia": Region.ASIA,
  "": Region.EMPTY,
  "Europe": Region.EUROPE,
  "Oceania": Region.OCEANIA,
  "Polar": Region.POLAR
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
