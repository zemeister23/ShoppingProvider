// To parse this JSON data, do
//
//     final LanguageModel = LanguageModelFromJson(jsonString);

import 'dart:convert';

LanguageModel LanguageModelFromJson(String str) => LanguageModel.fromJson(json.decode(str));

String LanguageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
    LanguageModel({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    List<Datum>? data;

    factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        status: json["status"],
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error_code": errorCode,
        "error_note": errorNote,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.langCode,
        this.name,
    });

    String? langCode;
    String? name;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        langCode: json["lang_code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "lang_code": langCode,
        "name": name,
    };
}
