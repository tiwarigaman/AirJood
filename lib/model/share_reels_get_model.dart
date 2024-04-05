// To parse this JSON data, do
//
//     final shareReelsGetModel = shareReelsGetModelFromJson(jsonString);

import 'dart:convert';

ShareReelsGetModel shareReelsGetModelFromJson(String str) =>
    ShareReelsGetModel.fromJson(json.decode(str));

String shareReelsGetModelToJson(ShareReelsGetModel data) =>
    json.encode(data.toJson());

class ShareReelsGetModel {
  int? id;
  int? userId;
  String? caption;
  dynamic dateOfShoot;
  String? location;
  int? songId;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? videoUrl;
  String? videoThumbnailUrl;
  int? likeCount;
  bool? liked;
  int? commentCount;
  List<User>? user;

  ShareReelsGetModel({
    this.id,
    this.userId,
    this.caption,
    this.dateOfShoot,
    this.location,
    this.songId,
    this.updatedAt,
    this.createdAt,
    this.videoUrl,
    this.videoThumbnailUrl,
    this.likeCount,
    this.liked,
    this.commentCount,
    this.user,
  });

  factory ShareReelsGetModel.fromJson(Map<String, dynamic> json) =>
      ShareReelsGetModel(
        id: json["id"],
        userId: json["user_id"],
        caption: json["caption"],
        dateOfShoot: json["date_of_shoot"],
        location: json["location"],
        songId: json["song_id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        videoUrl: json["video_url"],
        videoThumbnailUrl: json["video_thumbnail_url"],
        likeCount: json["like_count"],
        liked: json["liked"],
        commentCount: json["comment_count"],
        user: json["user"] == null
            ? []
            : List<User>.from(json["user"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "caption": caption,
        "date_of_shoot": dateOfShoot,
        "location": location,
        "song_id": songId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "video_url": videoUrl,
        "video_thumbnail_url": videoThumbnailUrl,
        "like_count": likeCount,
        "liked": liked,
        "comment_count": commentCount,
        "user": user == null
            ? []
            : List<dynamic>.from(user!.map((x) => x.toJson())),
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"]!.map((x) => x)),
        about: json["about"],
        contactNo: json["contact_no"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        gender: json["gender"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        profileImageUrl: json["profile_image_url"],
        isUpgrade: json["is_upgrade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "about": about,
        "contact_no": contactNo,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
      };
}
