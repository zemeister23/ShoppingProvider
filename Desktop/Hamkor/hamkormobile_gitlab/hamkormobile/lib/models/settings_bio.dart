// To parse this JSON data, do
//
//     final settingsBio = settingsBioFromJson(jsonString);

import 'dart:convert';

SettingsBio settingsBioFromJson(String str) => SettingsBio.fromJson(json.decode(str));

String settingsBioToJson(SettingsBio data) => json.encode(data.toJson());

class SettingsBio {
    SettingsBio({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory SettingsBio.fromJson(Map<String, dynamic> json) => SettingsBio(
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
        this.isSmile,
        this.resolution,
    });

    bool? isSmile;
    String? resolution;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        isSmile: json["is_smile"],
        resolution: json["resolution"],
    );

    Map<String, dynamic> toJson() => {
        "is_smile": isSmile,
        "resolution": resolution,
    };
}
