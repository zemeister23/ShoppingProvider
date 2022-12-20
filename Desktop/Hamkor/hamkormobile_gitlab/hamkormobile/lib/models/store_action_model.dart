// To parse this JSON data, do
//
//     final storeActionModel = storeActionModelFromJson(jsonString);

import 'dart:convert';

StoreActionModel storeActionModelFromJson(String str) =>
    StoreActionModel.fromJson(json.decode(str));

String storeActionModelToJson(StoreActionModel data) =>
    json.encode(data.toJson());

class StoreActionModel {
  StoreActionModel({
    this.data,
    this.errorCode,
    this.errorNote,
    this.status,
  });

  Data? data;
  int? errorCode;
  String? errorNote;
  String? status;

  factory StoreActionModel.fromJson(Map<String, dynamic> json) =>
      StoreActionModel(
        data: Data.fromJson(json["data"]),
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "error_code": errorCode,
        "error_note": errorNote,
        "status": status,
      };
}

class Data {
  Data({
    this.action,
    this.count,
    this.link,
  });

  int? action;
  num? count;
  String? link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        action: json["action"],
        count: json["count"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "count": count,
        "link": link,
      };
}
