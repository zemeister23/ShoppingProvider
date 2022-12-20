// To parse this JSON data, do
//
//     final bioPublicIdentifyModel = bioPublicIdentifyModelFromJson(jsonString);

import 'dart:convert';

BioPublicIdentifyModel bioPublicIdentifyModelFromJson(String str) => BioPublicIdentifyModel.fromJson(json.decode(str));
String bioPublicIdentifyModelToJson(BioPublicIdentifyModel data) => json.encode(data.toJson());
class BioPublicIdentifyModel {
    BioPublicIdentifyModel({
        this.errorCode,
        this.errorNote,
        this.status,
        this.data,
    });

    int? errorCode;
    String? errorNote;
    String? status;
    Data? data;

    factory BioPublicIdentifyModel.fromJson(Map<String, dynamic> json) => BioPublicIdentifyModel(
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_note": errorNote,
        "status": status,
        "data": data!.toJson(),
    };
}
class Data {
    Data({
        this.redirectUrl,
        this.ctoken,
    });

    String? redirectUrl;
    String? ctoken;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        redirectUrl: json["redirect_url"],
        ctoken: json["ctoken"],
    );

    Map<String, dynamic> toJson() => {
        "redirect_url": redirectUrl,
        "ctoken": ctoken,
    };
}
