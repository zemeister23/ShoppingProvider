// To parse this JSON data, do
//
//     final CardsBalancesModel = CardsBalancesModelFromJson(jsonString);

import 'dart:convert';

CardsBalancesModel CardsBalancesModelFromJson(String str) => CardsBalancesModel.fromJson(json.decode(str));

String CardsBalancesModelToJson(CardsBalancesModel data) => json.encode(data.toJson());

class CardsBalancesModel {
    CardsBalancesModel({
        this.status,
        this.errorCode,
        this.errorNote,
        this.data,
    });

    String? status;
    int? errorCode;
    String? errorNote;
    Data? data;

    factory CardsBalancesModel.fromJson(Map<String, dynamic> json) => CardsBalancesModel(
        status: json["status"],
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error_code": errorCode,
        "error_note": errorNote,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.totalSum,
        this.balances,
    });

    num? totalSum;
    List<Balance>? balances;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalSum: json["total_sum"].toDouble(),
        balances: List<Balance>.from(json["balances"].map((x) => Balance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_sum": totalSum,
        "balances": List<dynamic>.from(balances!.map((x) => x.toJson())),
    };
}

class Balance {
    Balance({
        this.cardId,
        this.balance,
    });

    String? cardId;
    num? balance;

    factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        cardId: json["card_id"],
        balance: json["balance"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "card_id": cardId,
        "balance": balance,
    };
}
