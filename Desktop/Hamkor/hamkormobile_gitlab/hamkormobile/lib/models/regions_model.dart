// To parse this JSON data, do
//
//     final regionsModel = regionsModelFromJson(jsonString);

import 'dart:convert';

RegionsModel regionsModelFromJson(String str) => RegionsModel.fromJson(json.decode(str));

String regionsModelToJson(RegionsModel data) => json.encode(data.toJson());

class RegionsModel {
    RegionsModel({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    List<dynamic>? data;

    factory RegionsModel.fromJson(Map<String, dynamic> json) => RegionsModel(
        status: json["status"],
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error_code": errorCode,
        "error_note": errorNote,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.code,
        this.title,
        this.rank,
        this.state,
    });

    String? code;
    String? title;
    String? rank;
    bool? state;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        code: json["code"],
        title: json["title"],
        rank: json["rank"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "rank": rank,
        "state": state,
    };
}
