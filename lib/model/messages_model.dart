// To parse this JSON data, do
//
//     final messagesModel = messagesModelFromJson(jsonString);

import 'dart:convert';

MessagesModel messagesModelFromJson(String str) => MessagesModel.fromJson(json.decode(str));

String messagesModelToJson(MessagesModel data) => json.encode(data.toJson());

class MessagesModel {
  bool? success;
  Data? data;
  String? message;

  MessagesModel({
    this.success,
    this.data,
    this.message,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<Message>? messages;
  Metadata? metadata;

  Data({
    this.messages,
    this.metadata,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "metadata": metadata?.toJson(),
  };
}

class Message {
  int? id;
  DateTime? createdAt;
  int? createdBy;
  int? toId;
  String? message;
  String? type;
  dynamic filePath;
  dynamic readAt;
  DateTime? updatedAt;
  Receiver? sender;
  Receiver? receiver;

  Message({
    this.id,
    this.createdAt,
    this.createdBy,
    this.toId,
    this.message,
    this.type,
    this.filePath,
    this.readAt,
    this.updatedAt,
    this.sender,
    this.receiver,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    toId: json["to_id"],
    message: json["message"],
    type: json["type"],
    filePath: json["file_path"],
    readAt: json["read_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
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
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
  };
}

class Receiver {
  int? id;
  List<String>? languages;
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
  String? profileImageUrl;
  bool? isUpgrade;
  bool? isFollowing;
  bool? isFollower;
  dynamic planInvitationStatus;

  Receiver({
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
    this.profileImageUrl,
    this.isUpgrade,
    this.isFollowing,
    this.isFollower,
    this.planInvitationStatus,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
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
    "profile_image_url": profileImageUrl,
    "is_upgrade": isUpgrade,
    "is_following": isFollowing,
    "is_follower": isFollower,
    "plan_invitation_status": planInvitationStatus,
  };
}

class Metadata {
  int? limit;
  int? offset;
  int? total;
  int? count;

  Metadata({
    this.limit,
    this.offset,
    this.total,
    this.count,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    limit: json["limit"],
    offset: json["offset"],
    total: json["total"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "offset": offset,
    "total": total,
    "count": count,
  };
}
