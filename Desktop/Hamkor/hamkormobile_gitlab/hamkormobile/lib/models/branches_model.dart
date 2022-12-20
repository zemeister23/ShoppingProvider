// To parse this JSON data, do
//
//     final branchesModel = branchesModelFromJson(jsonString);

import 'dart:convert';

BranchesModel branchesModelFromJson(String str) => BranchesModel.fromJson(json.decode(str));

String branchesModelToJson(BranchesModel data) => json.encode(data.toJson());

class BranchesModel {
    BranchesModel({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    List<Datum>? data;

    factory BranchesModel.fromJson(Map<String, dynamic> json) => BranchesModel(
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
        this.title,
        this.mfo,
        this.regionCode,
        this.coords,
        this.weekends,
        this.services,
        this.address,
        this.workTime,
        this.lunchTime,
        this.statusText,
        this.isOpen,
    });

    String? title;
    String? mfo;
    String? regionCode;
    Coords? coords;
    Address? weekends;
    Address? services;
    Address? address;
    Address? workTime;
    LunchTime? lunchTime;
    Address? statusText;
    bool? isOpen;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        mfo: json["mfo"],
        regionCode: json["region_code"],
        coords: Coords.fromJson(json["Coords"]),
        weekends: Address.fromJson(json["weekends"]),
        services: Address.fromJson(json["services"]),
        address: Address.fromJson(json["address"]),
        workTime: Address.fromJson(json["work_time"]),
        lunchTime: lunchTimeValues.map![json["lunch_time"]],
        statusText: Address.fromJson(json["status_text"]),
        isOpen: json["is_open"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "mfo": mfo,
        "region_code": regionCode,
        "Coords": coords!.toJson(),
        "weekends": weekends!.toJson(),
        "services": services!.toJson(),
        "address": address!.toJson(),
        "work_time": workTime!.toJson(),
        "lunch_time": lunchTimeValues.reverse[lunchTime],
        "status_text": statusText!.toJson(),
        "is_open": isOpen,
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
    En? en;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        uz: json["uz"],
        cy: json["cy"],
        ru: json["ru"],
        en: enValues.map![json["en"]],
    );

    Map<String, dynamic> toJson() => {
        "uz": uz,
        "cy": cy,
        "ru": ru,
        "en": enValues.reverse[en],
    };
}

enum En { EMPTY, CLOSED_UNTIL_0900_AM }

final enValues = EnumValues({
    "Closed until 09:00 AM": En.CLOSED_UNTIL_0900_AM,
    "": En.EMPTY
});

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

enum LunchTime { THE_12301330 }

final lunchTimeValues = EnumValues({
    "12:30-13:30": LunchTime.THE_12301330
});

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
