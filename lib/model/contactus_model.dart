// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  bool? success;
  Data? data;
  String? message;

  ContactUsModel({
    this.success,
    this.data,
    this.message,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
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
  String? siteDescription;
  String? contactNumber;
  String? emailAddress;
  String? address;
  String? latitude;
  String? longitude;

  Data({
    this.siteDescription,
    this.contactNumber,
    this.emailAddress,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    siteDescription: json["site_description"],
    contactNumber: json["contact_number"],
    emailAddress: json["email_address"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "site_description": siteDescription,
    "contact_number": contactNumber,
    "email_address": emailAddress,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
  };
}
