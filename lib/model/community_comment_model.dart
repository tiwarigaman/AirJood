
// To parse this JSON data, do
//
//     final communityCommentModel = communityCommentModelFromJson(jsonString);

import 'dart:convert';

CommunityCommentModel communityCommentModelFromJson(String str) => CommunityCommentModel.fromJson(json.decode(str));

String communityCommentModelToJson(CommunityCommentModel data) => json.encode(data.toJson());

class CommunityCommentModel {
  bool? success;
  Data? data;
  String? message;

  CommunityCommentModel({
    this.success,
    this.data,
    this.message,
  });

  factory CommunityCommentModel.fromJson(Map<String, dynamic> json) => CommunityCommentModel(
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
  int? currentPage;
  List<Datum>? data;
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  int? communityId;
  int? parentId;
  String? description;
  dynamic price;
  String? attachment;
  String? typeId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? createdBy;
  List<Datum>? replies;
  User? user;

  Datum({
    this.id,
    this.communityId,
    this.parentId,
    this.description,
    this.price,
    this.attachment,
    this.typeId,
    this.updatedAt,
    this.createdAt,
    this.createdBy,
    this.replies,
    this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    communityId: json["community_id"],
    parentId: json["parent_id"],
    description: json["description"],
    price: json["price"],
    attachment: json["attachment"],
    typeId: json["type_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    replies: json["replies"] == null ? [] : List<Datum>.from(json["replies"]!.map((x) => Datum.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "community_id": communityId,
    "parent_id": parentId,
    "description": description,
    "price": price,
    "attachment": attachment,
    "type_id": typeId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toJson())),
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
    this.isUpgrade,
    this.isFollowing,
    this.isFollower,
    this.planInvitationStatus,
    this.rating,
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
    rating: json["rating"],
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
    "rating": rating,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
