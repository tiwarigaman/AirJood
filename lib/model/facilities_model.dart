// To parse this JSON data, do
//
//     final facilitiesModel = facilitiesModelFromJson(jsonString);

import 'dart:convert';

FacilitiesModel facilitiesModelFromJson(String str) => FacilitiesModel.fromJson(json.decode(str));

String facilitiesModelToJson(FacilitiesModel data) => json.encode(data.toJson());

class FacilitiesModel {
  bool? success;
  List<Datum>? data;
  String? message;

  FacilitiesModel({
    this.success,
    this.data,
    this.message,
  });

  factory FacilitiesModel.fromJson(Map<String, dynamic> json) => FacilitiesModel(
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
  String? facility;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.facility,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    facility: json["facility"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "facility": facility,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
