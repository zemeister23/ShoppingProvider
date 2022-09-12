// To parse this JSON data, do
//
//     final succsesNumber = succsesNumberFromJson(jsonString);

import 'dart:convert';

SuccsesNumber succsesNumberFromJson(String str) => SuccsesNumber.fromJson(json.decode(str));

String succsesNumberToJson(SuccsesNumber data) => json.encode(data.toJson());

class SuccsesNumber {
    SuccsesNumber({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    Data? data;

    factory SuccsesNumber.fromJson(Map<String, dynamic> json) => SuccsesNumber(
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
        this.signId,
    });

    String? signId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        signId: json["sign_id"],
    );

    Map<String, dynamic> toJson() => {
        "sign_id": signId,
    };
}
