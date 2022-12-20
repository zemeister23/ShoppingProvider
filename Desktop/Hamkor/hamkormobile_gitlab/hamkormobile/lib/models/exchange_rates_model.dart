// To parse this JSON data, do
//
//     final exchangeRatesModel = exchangeRatesModelFromJson(jsonString);

import 'dart:convert';

ExchangeRatesModel exchangeRatesModelFromJson(String str) => ExchangeRatesModel.fromJson(json.decode(str));

String exchangeRatesModelToJson(ExchangeRatesModel data) => json.encode(data.toJson());

class ExchangeRatesModel {
    ExchangeRatesModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });
    List<Datum>? data;
    int? errorCode ;
    String? errorNote ;
    String? status;

    factory ExchangeRatesModel.fromJson(Map<String, dynamic> json) => ExchangeRatesModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error_code": errorCode,
        "error_note": errorNote,
        "status": status,
    };
}

class Datum {
    Datum({
        this.beginDate,
        this.beginSum,
        this.buyingRate,
        this.currencyChar,
        this.currencyCode,
        this.destination,
        this.endDate,
        this.endSum,
        this.id,
        this.quoteCurrency,
        this.sbCourse,
        this.sellingRate,
    });

    String? beginDate;
    String? beginSum;
    String? buyingRate;
    String? currencyChar;
    String? currencyCode;
    String? destination;
    String? endDate;
    String? endSum;
    String? id;
    String? quoteCurrency;
    String? sbCourse;
    String? sellingRate;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        beginDate: json["BeginDate"],
        beginSum: json["BeginSum"],
        buyingRate: json["BuyingRate"],
        currencyChar: json["CurrencyChar"],
        currencyCode: json["CurrencyCode"],
        destination: json["Destination"],
        endDate: json["EndDate"],
        endSum: json["EndSum"],
        id: json["Id"],
        quoteCurrency: json["QuoteCurrency"],
        sbCourse: json["SbCourse"],
        sellingRate: json["SellingRate"],
    );

    Map<String, dynamic> toJson() => {
        "BeginDate": beginDate,
        "BeginSum": beginSum,
        "BuyingRate": buyingRate,
        "CurrencyChar": currencyChar,
        "CurrencyCode": currencyCode,
        "Destination": destination,
        "EndDate": endDate,
        "EndSum": endSum,
        "Id": id,
        "QuoteCurrency": quoteCurrency,
        "SbCourse": sbCourse,
        "SellingRate": sellingRate,
    };
}
