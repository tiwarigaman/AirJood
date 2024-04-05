// To parse this JSON data, do
//
//     final reelsModel = reelsModelFromJson(jsonString);

import 'dart:convert';

ReelsModel reelsModelFromJson(String str) =>
    ReelsModel.fromJson(json.decode(str));

String reelsModelToJson(ReelsModel data) => json.encode(data.toJson());

class ReelsModel {
  int? currentPage;
  List<ReelsData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  ReelsModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ReelsModel.fromJson(Map<String, dynamic> json) => ReelsModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ReelsData>.from(
                json["data"]!.map((x) => ReelsData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ReelsData {
  int? id;
  int? userId;
  String? caption;
  DateTime? dateOfShoot;
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

  ReelsData({
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

  factory ReelsData.fromJson(Map<String, dynamic> json) => ReelsData(
        id: json["id"],
        userId: json["user_id"],
        caption: json["caption"],
        dateOfShoot: json["date_of_shoot"] == null
            ? null
            : DateTime.parse(json["date_of_shoot"]),
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
        "date_of_shoot": dateOfShoot?.toIso8601String(),
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
            : List<String>.from(json["languages"]!.map((x) => x!)),
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
        "about": about ?? '',
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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
