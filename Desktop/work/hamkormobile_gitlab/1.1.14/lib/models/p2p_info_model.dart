// To parse this JSON data, do
//
//     final p2PInfoModel = p2PInfoModelFromJson(jsonString);

import 'dart:convert';

P2PInfoModel p2PInfoModelFromJson(String str) => P2PInfoModel.fromJson(json.decode(str));

String p2PInfoModelToJson(P2PInfoModel data) => json.encode(data.toJson());

class P2PInfoModel {
    P2PInfoModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory P2PInfoModel.fromJson(Map<String, dynamic> json) => P2PInfoModel(
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
        this.bankCode,
        this.cardId,
        this.cardType,
        this.expire,
        this.isBankCard,
        this.owner,
        this.pan,
        this.processing,
    });

    String? bankCode;
    String? cardId;
    String? cardType;
    String? expire;
    bool? isBankCard;
    String? owner;
    String? pan;
    String? processing;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bankCode: json["bank_code"] == null ? null : json["bank_code"],
        cardId: json["card_id"] == null ? null : json["card_id"],
        cardType: json["card_type"] == null ? null : json["card_type"],
        expire: json["expire"] == null ? null : json["expire"],
        isBankCard: json["is_bank_card"] == null ? null : json["is_bank_card"],
        owner: json["owner"] == null ? null : json["owner"],
        pan: json["pan"] == null ? null : json["pan"],
        processing: json["processing"] == null ? null : json["processing"],
    );

    Map<String, dynamic> toJson() => {
        "bank_code": bankCode == null ? null : bankCode,
        "card_id": cardId == null ? null : cardId,
        "card_type": cardType == null ? null : cardType,
        "expire": expire == null ? null : expire,
        "is_bank_card": isBankCard == null ? null : isBankCard,
        "owner": owner == null ? null : owner,
        "pan": pan == null ? null : pan,
        "processing": processing == null ? null : processing,
    };
}
