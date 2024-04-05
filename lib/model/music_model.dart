// To parse this JSON data, do
//
//     final musicModel = musicModelFromJson(jsonString);

import 'dart:convert';

MusicModel musicModelFromJson(String str) =>
    MusicModel.fromJson(json.decode(str));

String musicModelToJson(MusicModel data) => json.encode(data.toJson());

class MusicModel {
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

  MusicModel({
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

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
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
  String? title;
  String? artistName;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? duration;
  String? songPathUrl;
  String? thumbnailPathUrl;
  bool? isPlaying;

  Datum({
    this.id,
    this.title,
    this.artistName,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.duration,
    this.songPathUrl,
    this.thumbnailPathUrl,
    this.isPlaying,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        artistName: json["artist_name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        duration: json["duration"],
        songPathUrl: json["song_path_url"],
        thumbnailPathUrl: json["thumbnail_path_url"],
        isPlaying: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "artist_name": artistName,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "duration": duration,
        "song_path_url": songPathUrl,
        "thumbnail_path_url": thumbnailPathUrl,
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
