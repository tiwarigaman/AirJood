// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  Data data;

  UserModel({
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  User user;
  String token;

  Data({
    required this.user,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
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
  bool? is_upgrade;
  bool? isFollowing;
  bool? isFollower;
  dynamic planInvitationStatus;
  int? rating;

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
    this.is_upgrade,
    this.isFollowing,
    this.isFollower,
    this.planInvitationStatus,
    this.rating,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        about: json["about"] ?? '',
        contactNo: json["contact_no"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        name: json["name"],
        role: json["role"] ?? '',
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] ?? '',
        profileImageUrl: json["profile_image_url"] ?? '',
        is_upgrade: json["is_upgrade"],
        isFollowing: json["is_following"],
        isFollower: json["is_follower"],
        planInvitationStatus: json["plan_invitation_status"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "about": about,
        "contact_no": contactNo,
        "dob":
            "${dob?.year.toString()}-${dob?.month.toString()}-${dob?.day.toString()}",
        "gender": gender,
        "name": name,
        "role": role,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "profile_image_url": profileImageUrl,
        "is_upgrade": is_upgrade,
        "is_following": isFollowing,
        "is_follower": isFollower,
        "plan_invitation_status": planInvitationStatus,
        "rating": rating,
      };
}
