// To parse this JSON data, do
//
//     final p2PConfirmModel = p2PConfirmModelFromJson(jsonString);

import 'dart:convert';

P2PConfirmModel p2PConfirmModelFromJson(String str) => P2PConfirmModel.fromJson(json.decode(str));

String p2PConfirmModelToJson(P2PConfirmModel data) => json.encode(data.toJson());

class P2PConfirmModel {
    P2PConfirmModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory P2PConfirmModel.fromJson(Map<String, dynamic> json) => P2PConfirmModel(
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
        this.commissionSum,
        this.operationTime,
        this.productName,
        this.receiverName,
        this.receiverPan,
        this.senderName,
        this.senderPan,
        this.status,
        this.sum,
        this.transactId,
    });

    num? commissionSum;
    String? operationTime;
    String? productName;
    String? receiverName;
    String? receiverPan;
    String? senderName;
    String? senderPan;
    String? status;
    num? sum;
    String? transactId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        commissionSum: json["commission_sum"] == null ? null : json["commission_sum"],
        operationTime: json["operation_time"] == null ? null : json["operation_time"],
        productName: json["product_name"] == null ? null : json["product_name"],
        receiverName: json["receiver_name"] == null ? null : json["receiver_name"],
        receiverPan: json["receiver_pan"] == null ? null : json["receiver_pan"],
        senderName: json["sender_name"] == null ? null : json["sender_name"],
        senderPan: json["sender_pan"] == null ? null : json["sender_pan"],
        status: json["status"] == null ? null : json["status"],
        sum: json["sum"] == null ? null : json["sum"],
        transactId: json["transact_id"] == null ? null : json["transact_id"],
    );

    Map<String, dynamic> toJson() => {
        "commission_sum": commissionSum == null ? null : commissionSum,
        "operation_time": operationTime == null ? null : operationTime,
        "product_name": productName == null ? null : productName,
        "receiver_name": receiverName == null ? null : receiverName,
        "receiver_pan": receiverPan == null ? null : receiverPan,
        "sender_name": senderName == null ? null : senderName,
        "sender_pan": senderPan == null ? null : senderPan,
        "status": status == null ? null : status,
        "sum": sum == null ? null : sum,
        "transact_id": transactId == null ? null : transactId,
    };
}
