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
  int? unreadCount;

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
    this.unreadCount,
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
    unreadCount: json["unread_count"],
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
    "unread_count": unreadCount,
  };
}

class Datum {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  DatumData? data;
  DateTime? readAt;
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
    readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type":notifiableType,
    "notifiable_id": notifiableId,
    "data": data?.toJson(),
    "read_at": readAt?.toIso8601String(),
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
  int? userId;
  int? reelId;
  int? invitedBy;
  int? invitationId;
  dynamic planId;
  int? followerId;
  int? senderId;
  int? receiverId;
  String? type;
  int? user;
  int? bookingId;
  dynamic experienceId;

  DataData({
    this.userId,
    this.reelId,
    this.invitedBy,
    this.invitationId,
    this.planId,
    this.followerId,
    this.senderId,
    this.receiverId,
    this.type,
    this.user,
    this.bookingId,
    this.experienceId,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    userId: json["user_id"],
    reelId: json["reel_id"],
    invitedBy: json["invited_by"],
    invitationId: json["invitation_id"],
    planId: json["plan_id"],
    followerId: json["follower_id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    type: json["type"],
    user: json["user"],
    bookingId: json["booking_id"],
    experienceId: json["experience_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "reel_id": reelId,
    "invited_by": invitedBy,
    "invitation_id": invitationId,
    "plan_id": planId,
    "follower_id": followerId,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "type":type,
    "user":user,
    "booking_id":bookingId,
    "experience_id":experienceId,
  };
}

class Metadata {
  Reel? reel;
  User? user;
  Plan? plan;
  Invitation? invitation;
  Receiver? receiver;
  dynamic message;
  Booking? booking;
  Experience? experience;

  Metadata({
    this.reel,
    this.user,
    this.plan,
    this.invitation,
    this.receiver,
    this.message,
    this.booking,
    this.experience,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    reel: json["reel"] == null ? null : Reel.fromJson(json["reel"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
    invitation: json["invitation"] == null ? null : Invitation.fromJson(json["invitation"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    message: json["message"],
    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
    experience: json["experience"] == null ? null : Experience.fromJson(json["experience"]),
  );

  Map<String, dynamic> toJson() => {
    "reel": reel?.toJson(),
    "user": user?.toJson(),
    "plan": plan?.toJson(),
    "invitation": invitation?.toJson(),
    "receiver": receiver?.toJson(),
    "message": message,
    "booking": booking?.toJson(),
    "experience": experience?.toJson(),
  };
}
class Booking {
  int? id;
  int? totalAmount;
  String? paymentMethod;
  int? experienceId;
  DateTime? date;
  String? addons;
  int? noOfGuests;
  int? bookingCharges;
  String? comment;
  int? reviewId;
  int? reviewNotificationSent;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? createdBy;
  List<Facility>? facility;
  List<Addonss>? addonss;

  Booking({
    this.id,
    this.totalAmount,
    this.paymentMethod,
    this.experienceId,
    this.date,
    this.addons,
    this.noOfGuests,
    this.bookingCharges,
    this.comment,
    this.reviewId,
    this.reviewNotificationSent,
    this.updatedAt,
    this.createdAt,
    this.createdBy,
    this.facility,
    this.addonss,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    totalAmount: json["total_amount"],
    paymentMethod: json["payment_method"],
    experienceId: json["experience_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    addons: json["addons"],
    noOfGuests: json["no_of_guests"],
    bookingCharges: json["booking_charges"],
    comment: json["comment"],
    reviewId: json["review_id"],
    reviewNotificationSent: json["review_notification_sent"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    facility: json["facility"] == null ? [] : List<Facility>.from(json["facility"]!.map((x) => Facility.fromJson(x))),
    addonss: json["addonss"] == null ? [] : List<Addonss>.from(json["addonss"]!.map((x) => Addonss.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_amount": totalAmount,
    "payment_method": paymentMethod,
    "experience_id": experienceId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "addons": addons,
    "no_of_guests": noOfGuests,
    "booking_charges": bookingCharges,
    "comment": comment,
    "review_id": reviewId,
    "review_notification_sent": reviewNotificationSent,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "facility": facility == null ? [] : List<dynamic>.from(facility!.map((x) => x.toJson())),
    "addonss": addonss == null ? [] : List<dynamic>.from(addonss!.map((x) => x.toJson())),
  };
}

class Addonss {
  int? id;
  int? reelId;
  int? experienceId;
  int? createdBy;
  String? name;
  String? description;
  int? price;
  String? priceType;
  dynamic reel;
  dynamic createdAt;
  dynamic updatedAt;

  Addonss({
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

  factory Addonss.fromJson(Map<String, dynamic> json) => Addonss(
    id: json["id"],
    reelId: json["reel_id"],
    experienceId: json["experience_id"],
    createdBy: json["created_by"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    priceType: json["price_type"],
    reel: json["reel"],
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
    "reel": reel,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
  int? rating;

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
    this.rating,
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
    "mood": mood == null ? [] : List<dynamic>.from(mood!.map((x) => x.toJson())),
    "facility": facility == null ? [] : List<dynamic>.from(facility!.map((x) => x.toJson())),
    "rating": rating,
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

class Plan {
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
    this.imageUrl,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
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

class Receiver {
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
  List<Receiver>? user;

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
    user: json["user"] == null ? [] : List<Receiver>.from(json["user"]!.map((x) => Receiver.fromJson(x))),
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
