// To parse this JSON data, do
//
//     final p2PInitModel = p2PInitModelFromJson(jsonString);

import 'dart:convert';

P2PInitModel p2PInitModelFromJson(String str) => P2PInitModel.fromJson(json.decode(str));

String p2PInitModelToJson(P2PInitModel data) => json.encode(data.toJson());

class P2PInitModel {
    P2PInitModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory P2PInitModel.fromJson(Map<String, dynamic> json) => P2PInitModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorNote: json["error_note"] == null ? null : json["error_note"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "error_code": errorCode == null ? null : errorCode,
        "error_note": errorNote == null ? null : errorNote,
        "status": status == null ? null : status,
    };
}

class Data {
    Data({
        this.signId,
    });

    String? signId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        signId: json["sign_id"] == null ? null : json["sign_id"],
    );

    Map<String, dynamic> toJson() => {
        "sign_id": signId == null ? null : signId,
    };
}
