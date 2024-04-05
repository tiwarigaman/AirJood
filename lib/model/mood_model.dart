// To parse this JSON data, do
//
//     final moodModel = moodModelFromJson(jsonString);

import 'dart:convert';

List<MoodModel> moodModelFromJson(dynamic jsonString) {
  if (jsonString is String) {
    // If jsonString is a string, parse it as a single JSON object
    return [MoodModel.fromJson(json.decode(jsonString))];
  } else if (jsonString is List) {
    // If jsonString is a list, parse each element as a separate JSON object
    return List<MoodModel>.from(jsonString.map((x) => MoodModel.fromJson(x)));
  } else {
    // Handle unexpected data type
    throw Exception('Unexpected data type for jsonString');
  }
}

String moodModelToJson(List<MoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoodModel {
  int? id;
  String? mood;
  DateTime? createdAt;
  DateTime? updatedAt;

  MoodModel({
    this.id,
    this.mood,
    this.createdAt,
    this.updatedAt,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) => MoodModel(
        id: json["id"],
        mood: json["mood"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mood": mood,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
