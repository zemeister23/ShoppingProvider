// To parse this JSON data, do
//
//     final depositsmodel = depositsmodelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_generator_number.dart';
part 'deposits_model.g.dart';
Depositsmodel depositsmodelFromJson(String str) => Depositsmodel.fromJson(json.decode(str));

@HiveType(typeId: HiveGeneratorNumber.DEPOSITS)
class Depositsmodel {
    Depositsmodel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });
    @HiveField(0)
    List<DepositsDatum>? data;
    @HiveField(1)
    int? errorCode;
    @HiveField(2)
    String? errorNote;
    @HiveField(3)
    String? status;

    factory Depositsmodel.fromJson(Map<String, dynamic> json) => Depositsmodel(
        data: List<DepositsDatum>.from(json["data"].map((x) => DepositsDatum.fromJson(x))),
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
    );

}

@HiveType(typeId: HiveGeneratorNumber.DEPOSITS_DATUM)
class DepositsDatum {
    DepositsDatum({
        this.amount,
        this.closeData,
        this.currency,
        this.months,
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
    num? months;
   @HiveField(4)
    String? name;
   @HiveField(5)
    num? rate;

    factory DepositsDatum.fromJson(Map<String, dynamic> json) => DepositsDatum(
        amount: json["Amount"],
        closeData: json["CloseData"],
        currency: json["Currency"],
        months: json["Months"],
        name: json["Name"],
        rate: json["Rate"],
    );


}
