// To parse this JSON data, do
//
//     final AddCardModel = AddCardModelFromJson(jsonString);

import 'dart:convert';

AddCardModel AddCardModelFromJson(String str) => AddCardModel.fromJson(json.decode(str));

String AddCardModelToJson(AddCardModel data) => json.encode(data.toJson());

class AddCardModel {
    AddCardModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory AddCardModel.fromJson(Map<String, dynamic> json) => AddCardModel(
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
        this.confirmMethod,
        this.signId,
    });

    String? confirmMethod;
    String? signId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        confirmMethod: json["confirm_method"],
        signId: json["sign_id"],
    );

    Map<String, dynamic> toJson() => {
        "confirm_method": confirmMethod,
        "sign_id": signId,
    };
}
