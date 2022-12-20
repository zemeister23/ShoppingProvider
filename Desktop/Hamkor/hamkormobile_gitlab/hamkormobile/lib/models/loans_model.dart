// To parse this JSON data, do
//
//     final loansModel = loansModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_generator_number.dart';
part 'loans_model.g.dart';
LoansModel loansModelFromJson(String str) =>
    LoansModel.fromJson(json.decode(str));

@HiveType(typeId: HiveGeneratorNumber.LOANS)
class LoansModel {
  LoansModel({
    this.data,
    this.errorCode,
    this.errorNote,
    this.status,
  });
  @HiveField(0)
  List<LoansDatumm>? data;
  @HiveField(1)
  int? errorCode;
  @HiveField(2)
  String? errorNote;
  @HiveField(3)
  String? status;

  factory LoansModel.fromJson(Map<String, dynamic> json) => LoansModel(
        data: json["data"] == null
            ? null
            : List<LoansDatumm>.from(json["data"].map((x) => LoansDatumm.fromJson(x)))
                .toList(),
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorNote: json["error_note"] == null ? null : json["error_note"],
        status: json["status"] == null ? null : json["status"],
      );
}

@HiveType(typeId: HiveGeneratorNumber.LOANS_DATUM)
class LoansDatumm {
  LoansDatumm({
    this.amount,
    this.closeData,
    this.currency,
    this.graphAmount,
    this.graphDay,
    this.name,
    this.rate,
  });

  @HiveField(0)
  num? amount;
  @HiveField(1)
  String? closeData;
  @HiveField(2)
  String? currency;
  @HiveField(3)
  num? graphAmount;
  @HiveField(4)
  String? graphDay;
  @HiveField(5)
  String? name;
  @HiveField(6)
  num? rate;

  factory LoansDatumm.fromJson(Map<String, dynamic> json) => LoansDatumm(
        amount: json["Amount"] == null ? null : json["Amount"],
        closeData: json["CloseData"] == null ? null : json["CloseData"],
        currency: json["Currency"] == null ? null : json["Currency"],
        graphAmount: json["GraphAmount"] == null ? null : json["GraphAmount"],
        graphDay: json["GraphDay"] == null ? null : json["GraphDay"],
        name: json["Name"] == null ? null : json["Name"],
        rate: json["Rate"] == null ? null : json["Rate"],
      );
}
