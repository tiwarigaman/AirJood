// To parse this JSON data, do
//
//     final facilitiesModel = facilitiesModelFromJson(jsonString);

import 'dart:convert';

List<FacilitiesModel> facilitiesModelFromJson(dynamic jsonString) {
  if (jsonString is String) {
    // If jsonString is a string, parse it as a single JSON object
    return [FacilitiesModel.fromJson(json.decode(jsonString))];
  } else if (jsonString is List) {
    // If jsonString is a list, parse each element as a separate JSON object
    return List<FacilitiesModel>.from(
        jsonString.map((x) => FacilitiesModel.fromJson(x)));
  } else {
    // Handle unexpected data type
    throw Exception('Unexpected data type for jsonString');
  }
}

String facilitiesModelToJson(List<FacilitiesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacilitiesModel {
  int? id;
  String? facility;
  DateTime? createdAt;
  DateTime? updatedAt;

  FacilitiesModel({
    this.id,
    this.facility,
    this.createdAt,
    this.updatedAt,
  });

  factory FacilitiesModel.fromJson(Map<String, dynamic> json) =>
      FacilitiesModel(
        id: json["id"],
        facility: json["facility"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "facility": facility,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
