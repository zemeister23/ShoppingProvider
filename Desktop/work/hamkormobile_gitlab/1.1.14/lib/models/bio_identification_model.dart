// To parse this JSON data, do
//
//     final bioIdentificationModel = bioIdentificationModelFromJson(jsonString);

import 'dart:convert';

BioIdentificationModel bioIdentificationModelFromJson(String str) => BioIdentificationModel.fromJson(json.decode(str));

String bioIdentificationModelToJson(BioIdentificationModel data) => json.encode(data.toJson());

class BioIdentificationModel {
    BioIdentificationModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory BioIdentificationModel.fromJson(Map<String, dynamic> json) => BioIdentificationModel(
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
        this.accessToken,
        this.refreshToken,
        this.url,
    });

    String? accessToken;
    String? refreshToken;
    String? url;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "url": url,
    };
}
