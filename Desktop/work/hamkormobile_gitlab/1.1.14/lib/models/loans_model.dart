// To parse this JSON data, do
//
//     final loansModel = loansModelFromJson(jsonString);

import 'dart:convert';

LoansModel loansModelFromJson(String str) => LoansModel.fromJson(json.decode(str));

class LoansModel {
    LoansModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    List<Datumm>? data;
    int? errorCode;
    String? errorNote;
    String? status;
    factory LoansModel.fromJson(Map<String, dynamic> json) => LoansModel(
        data: json["data"] == null ? null : List<Datumm>.from(json["data"].map((x) => Datumm.fromJson(x))).toList(),
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorNote: json["error_note"] == null ? null : json["error_note"],
        status: json["status"] == null ? null : json["status"],
    );
}
class Datumm {
    Datumm({
        this.amount,
        this.closeData,
        this.currency,
        this.graphAmount,
        this.graphDay,
        this.name,
        this.rate,
    });

    num? amount;
    String? closeData;
    String? currency;
    num? graphAmount;
    String? graphDay;
    String? name;
    num? rate;

    factory Datumm.fromJson(Map<String, dynamic> json) => Datumm(
        amount: json["Amount"] == null ? null : json["Amount"],
        closeData: json["CloseData"] == null ? null : json["CloseData"],
        currency: json["Currency"] == null ? null : json["Currency"],
        graphAmount: json["GraphAmount"] == null ? null : json["GraphAmount"],
        graphDay: json["GraphDay"] == null ? null : json["GraphDay"],
        name: json["Name"] == null ? null : json["Name"],
        rate: json["Rate"] == null ? null : json["Rate"],
    );
}
