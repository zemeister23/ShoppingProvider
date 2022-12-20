// To parse this JSON data, do
//
//     final phoneRegistation = phoneRegistationFromJson(jsonString);

import 'dart:convert';

PhoneRegistation phoneRegistationFromJson(String str) => PhoneRegistation.fromJson(json.decode(str));

String phoneRegistationToJson(PhoneRegistation data) => json.encode(data.toJson());

class PhoneRegistation {
    PhoneRegistation({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    Data? data;

    factory PhoneRegistation.fromJson(Map<String, dynamic> json) => PhoneRegistation(
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
