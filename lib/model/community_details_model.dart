// To parse this JSON data, do
//
//     final communityDetailsModel = communityDetailsModelFromJson(jsonString);

import 'dart:convert';

CommunityDetailsModel communityDetailsModelFromJson(String str) => CommunityDetailsModel.fromJson(json.decode(str));

String communityDetailsModelToJson(CommunityDetailsModel data) => json.encode(data.toJson());

class CommunityDetailsModel {
  bool? success;
  Data? data;
  String? message;

  CommunityDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory CommunityDetailsModel.fromJson(Map<String, dynamic> json) => CommunityDetailsModel(
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
  int? id;
  String? name;
  String? description;
  String? coverImage;
  String? profileImage;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? createdBy;
  int? memberCount;
  List<LatestMember>? latestMembers;
  bool? hasJoined;
  User? user;

  Data({
    this.id,
    this.name,
    this.description,
    this.coverImage,
    this.profileImage,
    this.updatedAt,
    this.createdAt,
    this.createdBy,
    this.memberCount,
    this.latestMembers,
    this.hasJoined,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    coverImage: json["cover_image"],
    profileImage: json["profile_image"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    memberCount: json["member_count"],
    latestMembers: json["latest_members"] == null ? [] : List<LatestMember>.from(json["latest_members"]!.map((x) => LatestMember.fromJson(x))),
    hasJoined: json["has_joined"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "cover_image": coverImage,
    "profile_image": profileImage,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "member_count": memberCount,
    "latest_members": latestMembers == null ? [] : List<dynamic>.from(latestMembers!.map((x) => x.toJson())),
    "has_joined": hasJoined,
    "user": user?.toJson(),
  };
}

class LatestMember {
  int? id;
  int? communityId;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  User? user;

  LatestMember({
    this.id,
    this.communityId,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.user,
  });

  factory LatestMember.fromJson(Map<String, dynamic> json) => LatestMember(
    id: json["id"],
    communityId: json["community_id"],
    userId: json["user_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "community_id": communityId,
    "user_id": userId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
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
  String? profileImageUrl;
  bool? isUpgrade;
  bool? isFollowing;
  bool? isFollower;
  dynamic planInvitationStatus;

  User({
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
    this.profileImageUrl,
    this.isUpgrade,
    this.isFollowing,
    this.isFollower,
    this.planInvitationStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    "profile_image_url": profileImageUrl,
    "is_upgrade": isUpgrade,
    "is_following": isFollowing,
    "is_follower": isFollower,
    "plan_invitation_status": planInvitationStatus,
  };
}
