// To parse this JSON data, do
//
//     final clientNameModel = clientNameModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_generator_number.dart';
part 'client_name_model.g.dart';
ClientNameModel clientNameModelFromJson(String str) =>
    ClientNameModel.fromJson(json.decode(str));

@HiveType(typeId: HiveGeneratorNumber.CLIENT_NAME)
class ClientNameModel {
  ClientNameModel({
    this.data,
    this.errorCode,
    this.errorNote,
    this.status,
  });

  @HiveField(0)
  ClientNameData? data;
  @HiveField(1)
  int? errorCode;
  @HiveField(2)
  String? errorNote;
  @HiveField(3)
  String? status;

  factory ClientNameModel.fromJson(Map<String, dynamic> json) =>
      ClientNameModel(
        data: ClientNameData.fromJson(json["data"]),
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
      );
}

@HiveType(typeId: HiveGeneratorNumber.CLIENT_NAME_DATA)
class ClientNameData {
  ClientNameData({
    this.firstName,
    this.lastName,
    this.middleName,
  });

  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? middleName;

  factory ClientNameData.fromJson(Map<String, dynamic> json) => ClientNameData(
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
      );
}
