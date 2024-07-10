// To parse this JSON data, do
//
//     final moodModel = moodModelFromJson(jsonString);

import 'dart:convert';

MoodModel moodModelFromJson(String str) => MoodModel.fromJson(json.decode(str));

String moodModelToJson(MoodModel data) => json.encode(data.toJson());

class MoodModel {
  bool? success;
  List<Mood>? data;
  String? message;

  MoodModel({
    this.success,
    this.data,
    this.message,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) => MoodModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Mood>.from(json["data"]!.map((x) => Mood.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Mood {
  int? id;
  String? mood;
  DateTime? createdAt;
  DateTime? updatedAt;

  Mood({
    this.id,
    this.mood,
    this.createdAt,
    this.updatedAt,
  });

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
    id: json["id"],
    mood: json["mood"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mood": mood,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
