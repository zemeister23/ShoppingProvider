// To parse this JSON data, do
//
//     final p2PValidateSucsesModel = p2PValidateSucsesModelFromJson(jsonString);

import 'dart:convert';

P2PValidateSucsesModel p2PValidateSucsesModelFromJson(String str) => P2PValidateSucsesModel.fromJson(json.decode(str));

String p2PValidateSucsesModelToJson(P2PValidateSucsesModel data) => json.encode(data.toJson());

class P2PValidateSucsesModel {
    P2PValidateSucsesModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory P2PValidateSucsesModel.fromJson(Map<String, dynamic> json) => P2PValidateSucsesModel(
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
        this.commissionSum,
        this.confirmMethod,
        this.isConfirm,
        this.transactId,
    });

    num? commissionSum;
    String? confirmMethod;
    bool? isConfirm;
    String? transactId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        commissionSum: json["commission_sum"] == null ? null : json["commission_sum"],
        confirmMethod: json["confirm_method"] == null ? null : json["confirm_method"],
        isConfirm: json["is_confirm"] == null ? null : json["is_confirm"],
        transactId: json["transact_id"] == null ? null : json["transact_id"],
    );

    Map<String, dynamic> toJson() => {
        "commission_sum": commissionSum == null ? null : commissionSum,
        "confirm_method": confirmMethod == null ? null : confirmMethod,
        "is_confirm": isConfirm == null ? null : isConfirm,
        "transact_id": transactId == null ? null : transactId,
    };
}
