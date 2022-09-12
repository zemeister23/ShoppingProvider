// To parse this JSON data, do
//
//     final TransactionModel = TransactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel TransactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String TransactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
    TransactionModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    List<Datum>? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
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
        this.commissionSum,
        this.operationTime,
        this.receiver,
        this.sender,
        this.status,
        this.sum,
        this.templateId,
    });

    num? commissionSum;
    String? operationTime;
    Receiver? receiver;
    Receiver? sender;
    String? status;
    num? sum;
    String? templateId;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        commissionSum: json["commission_sum"],
        operationTime: json["operation_time"],
        receiver: Receiver.fromJson(json["receiver"]),
        sender: Receiver.fromJson(json["sender"]),
        status: json["status"],
        sum: json["sum"],
        templateId: json["template_id"],
    );

    Map<String, dynamic> toJson() => {
        "commission_sum": commissionSum,
        "operation_time": operationTime,
        "receiver": receiver!.toJson(),
        "sender": sender!.toJson(),
        "status": status,
        "sum": sum,
        "template_id": templateId,
    };
}

class Receiver {
    Receiver({
        this.bankCode,
        this.expire,
        this.id,
        this.owner,
        this.pan,
        this.psCode,
    });

    String? bankCode;
    String? expire;
    String? id;
    String? owner;
    String? pan;
    String? psCode;

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        bankCode: json["bank_code"],
        expire: json["expire"],
        id: json["id"],
        owner: json["owner"],
        pan: json["pan"],
        psCode: json["ps_code"],
    );

    Map<String, dynamic> toJson() => {
        "bank_code": bankCode,
        "expire": expire,
        "id": id,
        "owner": owner,
        "pan": pan,
        "ps_code": psCode,
    };
}
