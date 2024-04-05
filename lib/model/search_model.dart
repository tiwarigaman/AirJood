// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'dart:convert';

SearchResultModel searchResultModelFromJson(String str) =>
    SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) =>
    json.encode(data.toJson());

class SearchResultModel {
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

  SearchResultModel({
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

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  int? id;
  int? relatedToMyPlan;
  int? reelId;
  String? latitude;
  String? longitude;
  dynamic availabilityForPersonFrom;
  dynamic availabilityForPersonTo;
  String? city;
  Country? country;
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
  PriceType? priceType;
  DateTime? startDate;
  DateTime? updatedAt;
  String? fridgetMagnetUrl;
  List<Facility>? mood;
  List<Facility>? facility;
  User? user;
  Reel? reel;

  Datum({
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
    this.user,
    this.reel,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        relatedToMyPlan: json["related_to_my_plan"],
        reelId: json["reel_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        availabilityForPersonFrom: json["availability_for_person_from"],
        availabilityForPersonTo: json["availability_for_person_to"],
        city: json["city"],
        country: countryValues.map[json["country"]]!,
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
        priceType: priceTypeValues.map[json["price_type"]]!,
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        "country": countryValues.reverse[country],
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
        "price_type": priceTypeValues.reverse[priceType],
        "start_date": startDate?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "fridget_magnet_url": fridgetMagnetUrl,
        "mood": mood == null
            ? []
            : List<dynamic>.from(mood!.map((x) => x.toJson())),
        "facility": facility == null
            ? []
            : List<dynamic>.from(facility!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "reel": reel?.toJson(),
      };
}

enum Country { FRANCE, INDIA }

final countryValues =
    EnumValues({"France": Country.FRANCE, "India": Country.INDIA});

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

enum PriceType { EXPERIENCE, PERSON }

final priceTypeValues = EnumValues(
    {"experience": PriceType.EXPERIENCE, "person": PriceType.PERSON});

class Reel {
  int? id;
  String? videoUrl;
  String? videoThumbnailUrl;
  int? likeCount;
  bool? liked;
  int? commentCount;
  List<dynamic>? user;

  Reel({
    this.id,
    this.videoUrl,
    this.videoThumbnailUrl,
    this.likeCount,
    this.liked,
    this.commentCount,
    this.user,
  });

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
        id: json["id"],
        videoUrl: json["video_url"],
        videoThumbnailUrl: json["video_thumbnail_url"],
        likeCount: json["like_count"],
        liked: json["liked"],
        commentCount: json["comment_count"],
        user: json["user"] == null
            ? []
            : List<dynamic>.from(json["user"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_url": videoUrl,
        "video_thumbnail_url": videoThumbnailUrl,
        "like_count": likeCount,
        "liked": liked,
        "comment_count": commentCount,
        "user": user == null ? [] : List<dynamic>.from(user!.map((x) => x)),
      };
}

class User {
  int? id;
  List<String>? languages;
  String? about;
  String? contactNo;
  DateTime? dob;
  Gender? gender;
  String? name;
  Role? role;
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
        gender: genderValues.map[json["gender"]]!,
        name: json["name"],
        role: roleValues.map[json["role"]]!,
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
        "gender": genderValues.reverse[gender],
        "name": name,
        "role": roleValues.reverse[role],
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "profile_image_url": profileImageUrl,
        "is_upgrade": isUpgrade,
      };
}

enum Gender { MALE }

final genderValues = EnumValues({"Male": Gender.MALE});

enum Role { GUIDE }

final roleValues = EnumValues({"guide": Role.GUIDE});

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
