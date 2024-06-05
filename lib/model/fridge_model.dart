// To parse this JSON data, do
//
//     final fridgeModel = fridgeModelFromJson(jsonString);

import 'dart:convert';

FridgeModel fridgeModelFromJson(String str) => FridgeModel.fromJson(json.decode(str));

String fridgeModelToJson(FridgeModel data) => json.encode(data.toJson());

class FridgeModel {
  bool? success;
  List<String>? data;
  String? message;

  FridgeModel({
    this.success,
    this.data,
    this.message,
  });

  factory FridgeModel.fromJson(Map<String, dynamic> json) => FridgeModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
