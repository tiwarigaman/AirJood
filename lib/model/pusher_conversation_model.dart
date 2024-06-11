// To parse this JSON data, do
//
//     final pusherConversationModel = pusherConversationModelFromJson(jsonString);

import 'dart:convert';

import 'messages_model.dart';

PusherConversationModel pusherConversationModelFromJson(String str) => PusherConversationModel.fromJson(json.decode(str));

String pusherConversationModelToJson(PusherConversationModel data) => json.encode(data.toJson());

class PusherConversationModel {
  Receiver? receiver;
  Receiver? sender;
  MessageData? message;

  PusherConversationModel({
    this.receiver,
    this.sender,
    this.message,
  });

  factory PusherConversationModel.fromJson(Map<String, dynamic> json) => PusherConversationModel(
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
    message: json["message"] == null ? null : MessageData.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "receiver": receiver?.toJson(),
    "sender": sender?.toJson(),
    "message": message?.toJson(),
  };
}

class MessageData {
  int? id;
  DateTime? createdAt;
  int? createdBy;
  int? toId;
  String? message;
  String? type;
  dynamic filePath;
  dynamic readAt;
  DateTime? updatedAt;

  MessageData({
    this.id,
    this.createdAt,
    this.createdBy,
    this.toId,
    this.message,
    this.type,
    this.filePath,
    this.readAt,
    this.updatedAt,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    toId: json["to_id"],
    message: json["message"],
    type: json["type"],
    filePath: json["file_path"],
    readAt: json["read_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "to_id": toId,
    "message": message,
    "type": type,
    "file_path": filePath,
    "read_at": readAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
