// To parse this JSON data, do
//
//     final smsPostModel = smsPostModelFromJson(jsonString);

import 'dart:convert';

SmsPostModel smsPostModelFromJson(String str) => SmsPostModel.fromJson(json.decode(str));

String smsPostModelToJson(SmsPostModel data) => json.encode(data.toJson());

class SmsPostModel {
    SmsPostModel({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    Data? data;

    factory SmsPostModel.fromJson(Map<String, dynamic> json) => SmsPostModel(
        status: json["status"],
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error_code": errorCode,
        "error_note": errorNote,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.refreshToken,
        this.accessToken,
    });

    String? refreshToken;
    String? accessToken;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "refresh_token": refreshToken,
        "access_token": accessToken,
    };
}
