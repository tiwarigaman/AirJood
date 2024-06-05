// To parse this JSON data, do
//
//     final planningDetailsModel = planningDetailsModelFromJson(jsonString);

import 'dart:convert';

PlanningDetailsModel planningDetailsModelFromJson(String str) => PlanningDetailsModel.fromJson(json.decode(str));

String planningDetailsModelToJson(PlanningDetailsModel data) => json.encode(data.toJson());

class PlanningDetailsModel {
  bool? success;
  Data? data;
  String? message;

  PlanningDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory PlanningDetailsModel.fromJson(Map<String, dynamic> json) => PlanningDetailsModel(
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
  String? planImage;
  String? title;
  String? country;
  String? state;
  DateTime? startDate;
  DateTime? endDate;
  int? planDuration;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? createdBy;
  String? countryName;
  String? stateName;
  String? imageUrl;
  List<PlanReel>? planReels;
  List<Invitation>? invitations;

  Data({
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
    this.imageUrl,
    this.planReels,
    this.invitations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    planImage: json["plan_image"],
    title: json["title"],
    country: json["country"],
    state: json["state"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    planDuration: json["plan_duration"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    imageUrl: json["image_url"],
    planReels: json["plan_reels"] == null ? [] : List<PlanReel>.from(json["plan_reels"]!.map((x) => PlanReel.fromJson(x))),
    invitations: json["invitations"] == null ? [] : List<Invitation>.from(json["invitations"]!.map((x) => Invitation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_image": planImage,
    "title": title,
    "country": country,
    "state": state,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "plan_duration": planDuration,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "country_name": countryName,
    "state_name": stateName,
    "image_url": imageUrl,
    "plan_reels": planReels == null ? [] : List<dynamic>.from(planReels!.map((x) => x.toJson())),
    "invitations": invitations == null ? [] : List<dynamic>.from(invitations!.map((x) => x.toJson())),
  };
}

class Invitation {
  int? id;
  int? planId;
  int? userId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Invitation({
    this.id,
    this.planId,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
    id: json["id"],
    planId: json["plan_id"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_id": planId,
    "user_id": userId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
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
  };
}

class PlanReel {
  int? id;
  int? userId;
  int? planId;
  int? experienceId;
  String? dayCount;
  dynamic date;
  DateTime? startTime;
  DateTime? endTime;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  Experience? experience;

  PlanReel({
    this.id,
    this.userId,
    this.planId,
    this.experienceId,
    this.dayCount,
    this.date,
    this.startTime,
    this.endTime,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.experience,
  });

  factory PlanReel.fromJson(Map<String, dynamic> json) => PlanReel(
    id: json["id"],
    userId: json["user_id"],
    planId: json["plan_id"],
    experienceId: json["experience_id"],
    dayCount: json["day_count"],
    date: json["date"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    notes: json["notes"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    experience: json["experience"] == null ? null : Experience.fromJson(json["experience"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "plan_id": planId,
    "experience_id": experienceId,
    "day_count": dayCount,
    "date": date,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime?.toIso8601String(),
    "notes": notes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "experience": experience?.toJson(),
  };
}

class Experience {
  int? id;
  int? relatedToMyPlan;
  int? reelId;
  String? latitude;
  String? longitude;
  dynamic availabilityForPersonFrom;
  dynamic availabilityForPersonTo;
  String? city;
  String? country;
  String? state;
  DateTime? createdAt;
  int? createdBy;
  String? description;
  DateTime? endDate;
  dynamic file;
  String? location;
  int? maxPerson;
  int? minPerson;
  String? name;
  int? price;
  String? priceType;
  DateTime? startDate;
  DateTime? updatedAt;
  String? fridgetMagnetUrl;
  List<Facility>? mood;
  List<Facility>? facility;
  Reel? reel;

  Experience({
    this.id,
    this.relatedToMyPlan,
    this.reelId,
    this.latitude,
    this.longitude,
    this.availabilityForPersonFrom,
    this.availabilityForPersonTo,
    this.city,
    this.country,
    this.state,
    this.createdAt,
    this.createdBy,
    this.description,
    this.endDate,
    this.file,
    this.location,
    this.maxPerson,
    this.minPerson,
    this.name,
    this.price,
    this.priceType,
    this.startDate,
    this.updatedAt,
    this.fridgetMagnetUrl,
    this.mood,
    this.facility,
    this.reel,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json["id"],
    relatedToMyPlan: json["related_to_my_plan"],
    reelId: json["reel_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    availabilityForPersonFrom: json["availability_for_person_from"],
    availabilityForPersonTo: json["availability_for_person_to"],
    city: json["city"],
    country: json["country"],
    state: json["state"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    description: json["description"],
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    file: json["file"],
    location: json["location"],
    maxPerson: json["max_person"],
    minPerson: json["min_person"],
    name: json["name"],
    price: json["price"],
    priceType: json["price_type"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    fridgetMagnetUrl: json["fridget_magnet_url"],
    mood: json["mood"] == null ? [] : List<Facility>.from(json["mood"]!.map((x) => Facility.fromJson(x))),
    facility: json["facility"] == null ? [] : List<Facility>.from(json["facility"]!.map((x) => Facility.fromJson(x))),
    reel: json["reel"] == null ? null : Reel.fromJson(json["reel"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "related_to_my_plan": relatedToMyPlan,
    "reel_id": reelId,
    "latitude": latitude,
    "longitude": longitude,
    "availability_for_person_from": availabilityForPersonFrom,
    "availability_for_person_to": availabilityForPersonTo,
    "city": city,
    "country": country,
    "state": state,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "description": description,
    "end_date": endDate?.toIso8601String(),
    "file": file,
    "location": location,
    "max_person": maxPerson,
    "min_person": minPerson,
    "name": name,
    "price": price,
    "price_type": priceType,
    "start_date": startDate?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "fridget_magnet_url": fridgetMagnetUrl,
    "mood": mood == null ? [] : List<dynamic>.from(mood!.map((x) => x.toJson())),
    "facility": facility == null ? [] : List<dynamic>.from(facility!.map((x) => x.toJson())),
    "reel": reel?.toJson(),
  };
}

class Facility {
  int? id;
  String? facility;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? mood;

  Facility({
    this.id,
    this.facility,
    this.createdAt,
    this.updatedAt,
    this.mood,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
    id: json["id"],
    facility: json["facility"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    mood: json["mood"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "facility": facility,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "mood": mood,
  };
}

class Reel {
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

  Reel({
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

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
    id: json["id"],
    userId: json["user_id"],
    caption: json["caption"],
    dateOfShoot: json["date_of_shoot"] == null ? null : DateTime.parse(json["date_of_shoot"]),
    location: json["location"],
    songId: json["song_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    videoUrl: json["video_url"],
    videoThumbnailUrl: json["video_thumbnail_url"],
    likeCount: json["like_count"],
    liked: json["liked"],
    commentCount: json["comment_count"],
    user: json["user"] == null ? [] : List<User>.from(json["user"]!.map((x) => User.fromJson(x))),
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
    "user": user == null ? [] : List<dynamic>.from(user!.map((x) => x.toJson())),
  };
}
