// To parse this JSON data, do
//
//     final razvilkaModel = razvilkaModelFromJson(jsonString);

import 'dart:convert';

RazvilkaModel razvilkaModelFromJson(String str) => RazvilkaModel.fromJson(json.decode(str));

String razvilkaModelToJson(RazvilkaModel data) => json.encode(data.toJson());

class RazvilkaModel {
    RazvilkaModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory RazvilkaModel.fromJson(Map<String, dynamic> json) => RazvilkaModel(
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
        this.countOrder,
        this.link,
    });

    int? countOrder;
    String? link;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        countOrder: json["count_order"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "count_order": countOrder,
        "link": link,
    };
}
