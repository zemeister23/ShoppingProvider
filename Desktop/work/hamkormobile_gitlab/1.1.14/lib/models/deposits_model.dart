// To parse this JSON data, do
//
//     final depositsmodel = depositsmodelFromJson(jsonString);

import 'dart:convert';

Depositsmodel depositsmodelFromJson(String str) => Depositsmodel.fromJson(json.decode(str));


class Depositsmodel {
    Depositsmodel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    List<Datum>? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory Depositsmodel.fromJson(Map<String, dynamic> json) => Depositsmodel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
    );

}

class Datum {
    Datum({
        this.amount,
        this.closeData,
        this.currency,
        this.months,
        this.name,
        this.rate,
    });

    num? amount;
    String? closeData;
    String? currency;
    num? months;
    String? name;
    num? rate;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        amount: json["Amount"],
        closeData: json["CloseData"],
        currency: json["Currency"],
        months: json["Months"],
        name: json["Name"],
        rate: json["Rate"],
    );


}
