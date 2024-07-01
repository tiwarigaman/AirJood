// To parse this JSON data, do
//
//     final conversationsModel = conversationsModelFromJson(jsonString);

import 'dart:convert';

ConversationsModel conversationsModelFromJson(String str) => ConversationsModel.fromJson(json.decode(str));

String conversationsModelToJson(ConversationsModel data) => json.encode(data.toJson());

class ConversationsModel {
  bool? success;
  List<ConversationsData>? data;
  String? message;

  ConversationsModel({
    this.success,
    this.data,
    this.message,
  });

  factory ConversationsModel.fromJson(Map<String, dynamic> json) => ConversationsModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<ConversationsData>.from(json["data"]!.map((x) => ConversationsData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class ConversationsData {
  int? id;
  final List? languages;
  String? about;
  String? contactNo;
  DateTime? dob;
  String? gender;
  String? name;
  String? role;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? unreadCount;
  LastMessage? lastMessage;
  String? profileImageUrl;
  bool? isUpgrade;
  bool? isFollowing;
  bool? isFollower;
  dynamic planInvitationStatus;

  ConversationsData({
    this.id,
    this.languages,
    this.about,
    this.contactNo,
    this.dob,
    this.gender,
    this.name,
    this.role,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.unreadCount,
    this.lastMessage,
    this.profileImageUrl,
    this.isUpgrade,
    this.isFollowing,
    this.isFollower,
    this.planInvitationStatus,
  });

  factory ConversationsData.fromJson(Map<String, dynamic> json) => ConversationsData(
    id: json["id"],
    languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
    about: json["about"],
    contactNo: json["contact_no"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    name: json["name"],
    role: json["role"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    unreadCount: json["unread_count"],
    lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
    profileImageUrl: json["profile_image_url"],
    isUpgrade: json["is_upgrade"],
    isFollowing: json["is_following"],
    isFollower: json["is_follower"],
    planInvitationStatus: json["plan_invitation_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
    "about": about,
    "contact_no": contactNo,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "name": name,
    "role": role,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "unread_count": unreadCount,
    "last_message": lastMessage?.toJson(),
    "profile_image_url": profileImageUrl,
    "is_upgrade": isUpgrade,
    "is_following": isFollowing,
    "is_follower": isFollower,
    "plan_invitation_status": planInvitationStatus,
  };
}

class LastMessage {
  int? id;
  DateTime? createdAt;
  int? createdBy;
  int? toId;
  String? message;
  String? type;
  dynamic filePath;
  dynamic readAt;
  DateTime? updatedAt;

  LastMessage({
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

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
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
