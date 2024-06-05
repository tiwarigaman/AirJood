// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
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

  NotificationModel({
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

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  DatumData? data;
  dynamic readAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Metadata? metadata;

  Datum({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    notifiableType: json["notifiable_type"],
    notifiableId: json["notifiable_id"],
    data: json["data"] == null ? null : DatumData.fromJson(json["data"]),
    readAt: json["read_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data?.toJson(),
    "read_at": readAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "metadata": metadata?.toJson(),
  };
}

class DatumData {
  String? type;
  String? message;
  DataData? data;

  DatumData({
    this.type,
    this.message,
    this.data,
  });

  factory DatumData.fromJson(Map<String, dynamic> json) => DatumData(
    type: json["type"],
    message: json["message"],
    data: json["data"] == null ? null : DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataData {
  int? invitedBy;
  int? invitationId;
  dynamic planId;

  DataData({
    this.invitedBy,
    this.invitationId,
    this.planId,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    invitedBy: json["invited_by"],
    invitationId: json["invitation_id"],
    planId: json["plan_id"],
  );

  Map<String, dynamic> toJson() => {
    "invited_by": invitedBy,
    "invitation_id": invitationId,
    "plan_id": planId,
  };
}

class Metadata {
  InvitedBy? invitedBy;
  Plan? plan;
  Invitation? invitation;

  Metadata({
    this.invitedBy,
    this.plan,
    this.invitation,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    invitedBy: json["invited_by"] == null ? null : InvitedBy.fromJson(json["invited_by"]),
    plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
    invitation: json["invitation"] == null ? null : Invitation.fromJson(json["invitation"]),
  );

  Map<String, dynamic> toJson() => {
    "invited_by": invitedBy?.toJson(),
    "plan": plan?.toJson(),
    "invitation": invitation?.toJson(),
  };
}

class Invitation {
  int? id;
  int? planId;
  int? userId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Invitation({
    this.id,
    this.planId,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
    id: json["id"],
    planId: json["plan_id"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_id": planId,
    "user_id": userId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class InvitedBy {
  int? id;
  List<String>? languages;
  dynamic about;
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

  InvitedBy({
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

  factory InvitedBy.fromJson(Map<String, dynamic> json) => InvitedBy(
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

class Plan {
  int? id;
  String? planImage;
  String? title;
  String? country;
  String? state;
  dynamic startDate;
  dynamic endDate;
  int? planDuration;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? createdBy;
  String? countryName;
  String? stateName;

  Plan({
    this.id,
    this.planImage,
    this.title,
    this.country,
    this.state,
    this.startDate,
    this.endDate,
    this.planDuration,
    this.updatedAt,
    this.createdAt,
    this.createdBy,
    this.countryName,
    this.stateName,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    planImage: json["plan_image"],
    title: json["title"],
    country: json["country"],
    state: json["state"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    planDuration: json["plan_duration"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    countryName: json["country_name"],
    stateName: json["state_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_image": planImage,
    "title": title,
    "country": country,
    "state": state,
    "start_date": startDate,
    "end_date": endDate,
    "plan_duration": planDuration,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "country_name": countryName,
    "state_name": stateName,
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
