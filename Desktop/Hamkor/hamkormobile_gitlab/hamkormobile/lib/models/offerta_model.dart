// To parse this JSON data, do
//
//     final OffertaModel = OffertaModelFromJson(jsonString);

import 'dart:convert';

OffertaModel OffertaModelFromJson(String str) => OffertaModel.fromJson(json.decode(str));

String OffertaModelToJson(OffertaModel data) => json.encode(data.toJson());

class OffertaModel {
    OffertaModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory OffertaModel.fromJson(Map<String, dynamic> json) => OffertaModel(
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
        this.isShortTitle,
        this.shortText,
        this.text,
    });

    bool? isShortTitle;
    String? shortText;
    String? text;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        isShortTitle: json["is_short_title"],
        shortText: json["short_text"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "is_short_title": isShortTitle,
        "short_text": shortText,
        "text": text,
    };
}
