// To parse this JSON data, do
//
//     final clientCardsModel = clientCardsModelFromJson(jsonString);

import 'dart:convert';

ClientCardsModel clientCardsModelFromJson(String str) => ClientCardsModel.fromJson(json.decode(str));

String clientCardsModelToJson(ClientCardsModel data) => json.encode(data.toJson());

class ClientCardsModel {
    ClientCardsModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory ClientCardsModel.fromJson(Map<String, dynamic> json) => ClientCardsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorNote: json["error_note"] == null ? null : json["error_note"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "error_code": errorCode == null ? null : errorCode,
        "error_note": errorNote == null ? null : errorNote,
        "status": status == null ? null : status,
    };
}

class Data {
    Data({
        this.cards,
        this.totalSum,
    });

    List<Card>? cards;
    num? totalSum;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cards: json["cards"] == null ? null : List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        totalSum: json["total_sum"] == null ? null : json["total_sum"],
    );

    Map<String, dynamic> toJson() => {
        "cards": cards == null ? null : List<dynamic>.from(cards!.map((x) => x.toJson())),
        "total_sum": totalSum == null ? null : totalSum,
    };
}

class Card {
    Card({
        this.balance,
        this.cardId,
        this.cardType,
        this.expire,
        this.maskNum,
        this.mfo,
        this.owner,
        this.psCode,
        this.state,
    });

    num? balance;
    String? cardId;
    String? cardType;
    String? expire;
    String? maskNum;
    String? mfo;
    String? owner;
    String? psCode;
    String? state;

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        balance: json["balance"] == null ? null : json["balance"],
        cardId: json["card_id"] == null ? null : json["card_id"],
        cardType: json["card_type"] == null ? null : json["card_type"],
        expire: json["expire"] == null ? null : json["expire"],
        maskNum: json["mask_num"] == null ? null : json["mask_num"],
        mfo: json["mfo"] == null ? null : json["mfo"],
        owner: json["owner"] == null ? null : json["owner"],
        psCode: json["ps_code"] == null ? null : json["ps_code"],
        state: json["state"] == null ? null : json["state"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance == null ? null : balance,
        "card_id": cardId == null ? null : cardId,
        "card_type": cardType == null ? null : cardType,
        "expire": expire == null ? null : expire,
        "mask_num": maskNum == null ? null : maskNum,
        "mfo": mfo == null ? null : mfo,
        "owner": owner == null ? null : owner,
        "ps_code": psCode == null ? null : psCode,
        "state": state == null ? null : state,
    };
}
