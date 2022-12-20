// To parse this JSON data, do
//
//     final bioRigistration = bioRigistrationFromJson(jsonString);

import 'dart:convert';

BioRigistration bioRigistrationFromJson(String str) => BioRigistration.fromJson(json.decode(str));

String bioRigistrationToJson(BioRigistration data) => json.encode(data.toJson());

class BioRigistration {
    BioRigistration({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory BioRigistration.fromJson(Map<String, dynamic> json) => BioRigistration(
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
        this.confirmMethod,
        this.refreshToken,
        this.signId,
    });

    String? accessToken;
    String? confirmMethod;
    String? refreshToken;
    String? signId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        confirmMethod: json["confirm_method"],
        refreshToken: json["refresh_token"],
        signId: json["sign_id"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "confirm_method": confirmMethod,
        "refresh_token": refreshToken,
        "sign_id": signId,
    };
}
