// To parse this JSON data, do
//
//     final clientNameModel = clientNameModelFromJson(jsonString);

import 'dart:convert';

ClientNameModel clientNameModelFromJson(String str) => ClientNameModel.fromJson(json.decode(str));

class ClientNameModel {
    ClientNameModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory ClientNameModel.fromJson(Map<String, dynamic> json) => ClientNameModel(
        data: Data.fromJson(json["data"]),
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
    );

}

class Data {
    Data({
        this.firstName,
        this.lastName,
        this.middleName,
    });

    String? firstName;
    String? lastName;
    String? middleName;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
    );

}
