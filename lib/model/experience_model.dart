// To parse this JSON data, do
//
//     final experienceModel = experienceModelFromJson(jsonString);

import 'dart:convert';

ExperienceModel experienceModelFromJson(String str) =>
    ExperienceModel.fromJson(json.decode(str));

String experienceModelToJson(ExperienceModel data) =>
    json.encode(data.toJson());

class ExperienceModel {
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
  List<Addon>? addons;
  int? rating;
  List<Reel>? reel;

  ExperienceModel({
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
    this.addons,
    this.reel,
    this.rating,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      ExperienceModel(
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        description: json["description"],
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        file: json["file"],
        location: json["location"],
        maxPerson: json["max_person"],
        minPerson: json["min_person"],
        name: json["name"],
        price: json["price"],
        priceType: json["price_type"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fridgetMagnetUrl: json["fridget_magnet_url"],
        mood: json["mood"] == null
            ? []
            : List<Facility>.from(
                json["mood"]!.map((x) => Facility.fromJson(x))),
        facility: json["facility"] == null
            ? []
            : List<Facility>.from(
                json["facility"]!.map((x) => Facility.fromJson(x))),
        addons: json["addons"] == null
            ? []
            : List<Addon>.from(json["addons"]!.map((x) => Addon.fromJson(x))),
        reel: json["reel"] == null
            ? []
            : List<Reel>.from(json["reel"]!.map((x) => Reel.fromJson(x))),
        rating: json["rating"],
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
        "mood": mood == null
            ? []
            : List<dynamic>.from(mood!.map((x) => x.toJson())),
        "facility": facility == null
            ? []
            : List<dynamic>.from(facility!.map((x) => x.toJson())),
        "addons": addons == null
            ? []
            : List<dynamic>.from(addons!.map((x) => x.toJson())),
        "reel": reel == null
            ? []
            : List<dynamic>.from(reel!.map((x) => x.toJson())),
        "rating": rating,
      };
}

class Addon {
  int? id;
  int? reelId;
  int? experienceId;
  int? createdBy;
  String? name;
  String? description;
  int? price;
  String? priceType;
  Reel? reel;
  dynamic createdAt;
  dynamic updatedAt;

  Addon({
    this.id,
    this.reelId,
    this.experienceId,
    this.createdBy,
    this.name,
    this.description,
    this.price,
    this.priceType,
    this.reel,
    this.createdAt,
    this.updatedAt,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        id: json["id"],
        reelId: json["reel_id"],
        experienceId: json["experience_id"],
        createdBy: json["created_by"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        priceType: json["price_type"],
        reel: json["reel"] == null ? null : Reel.fromJson(json["reel"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reel_id": reelId,
        "experience_id": experienceId,
        "created_by": createdBy,
        "name": name,
        "description": description,
        "price": price,
        "price_type": priceType,
        "reel": reel?.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
