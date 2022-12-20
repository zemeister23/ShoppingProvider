// To parse this JSON data, do
//
//     final dataBancomats = dataBancomatsFromJson(jsonString);

import 'dart:convert';

DataBancomats dataBancomatsFromJson(String str) => DataBancomats.fromJson(json.decode(str));

String dataBancomatsToJson(DataBancomats data) => json.encode(data.toJson());

class DataBancomats {
    DataBancomats({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    List<Datum>? data;

    factory DataBancomats.fromJson(Map<String, dynamic> json) => DataBancomats(
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
        this.mfo,
        this.type,
        this.coords,
        this.regionCode,
        this.orienter,
        this.workTime,
        this.workDays,
        this.atmType,
        this.address,
    });

    String? mfo;
    Type? type;
    Coords? coords;
    String? regionCode;
    Address? orienter;
    Address? workTime;
    Address? workDays;
    Address? atmType;
    Address? address;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        mfo: json["mfo"],
        type: typeValues.map![json["type"]],
        coords: Coords.fromJson(json["Coords"]),
        regionCode: json["region_code"],
        orienter: Address.fromJson(json["orienter"]),
        workTime: Address.fromJson(json["work_time"]),
        workDays: Address.fromJson(json["work_days"]),
        atmType: Address.fromJson(json["atm_type"]),
        address: Address.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "mfo": mfo,
        "type": typeValues.reverse![type],
        "Coords": coords!.toJson(),
        "region_code": regionCode,
        "orienter": orienter!.toJson(),
        "work_time": workTime!.toJson(),
        "work_days": workDays!.toJson(),
        "atm_type": atmType!.toJson(),
        "address": address!.toJson(),
    };
}

class Address {
    Address({
        this.uz,
        this.cy,
        this.ru,
        this.en,
    });

    String? uz;
    String? cy;
    String? ru;
    String? en;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        uz: json["uz"],
        cy: json["cy"],
        ru: json["ru"],
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "uz": uz,
        "cy": cy,
        "ru": ru,
        "en": en,
    };
}

class Coords {
    Coords({
        this.lat,
        this.lng,
    });

    String? lat;
    String? lng;

    factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        lat: json["lat"],
        lng: json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

enum Type { HUMO, UZCARD }

final typeValues = EnumValues({
    "Humo": Type.HUMO,
    "Uzcard": Type.UZCARD
});

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
