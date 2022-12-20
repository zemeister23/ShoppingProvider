// To parse this JSON data, do
//
//     final OperatorsModel = OperatorsModelFromJson(jsonString);

import 'dart:convert';

OperatorsModel OperatorsModelFromJson(String str) => OperatorsModel.fromJson(json.decode(str));

String OperatorsModelToJson(OperatorsModel data) => json.encode(data.toJson());

class OperatorsModel {
    OperatorsModel({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    List<Datum>? data;

    factory OperatorsModel.fromJson(Map<String, dynamic> json) => OperatorsModel(
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
        this.operatorId,
        this.mask,
        this.name,
    });

    String? operatorId;
    String? mask;
    String? name;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        operatorId: json["operator_id"],
        mask: json["mask"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "operator_id": operatorId,
        "mask": mask,
        "name": name,
    };
}
