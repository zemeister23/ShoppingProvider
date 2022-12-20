// To parse this JSON data, do
//
//     final p2PLastModel = p2PLastModelFromJson(jsonString);

import 'dart:convert';

P2PLastModel p2PLastModelFromJson(String str) => P2PLastModel.fromJson(json.decode(str));

String p2PLastModelToJson(P2PLastModel data) => json.encode(data.toJson());

class P2PLastModel {
    P2PLastModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });
    List<Datum>? data;
    int? errorCode;
    String?errorNote;
    String? status;
    factory P2PLastModel.fromJson(Map<String, dynamic> json) => P2PLastModel(
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
        this.receiverId,
        this.receiverMfo,
        this.receiverName,
        this.receiverPan,
        this.receiverPs,
        this.senderId,
        this.senderMfo,
        this.senderPan,
        this.senderPs,
        this.status,
        this.sum,
    });

    var commissionSum;
    String? operationTime;
    String? receiverId;
    String? receiverMfo;
    String? receiverName;
    String? receiverPan;
    String? receiverPs;
    String? senderId;
    String? senderMfo;
    String? senderPan;
    String? senderPs;
    String? status;
    var sum;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        commissionSum: json["commission_sum"],
        operationTime: json["operation_time"],
        receiverId: json["receiver_id"],
        receiverMfo: json["receiver_mfo"],
        receiverName: json["receiver_name"],
        receiverPan: json["receiver_pan"],
        receiverPs: json["receiver_ps"],
        senderId: json["sender_id"],
        senderMfo: json["sender_mfo"],
        senderPan: json["sender_pan"],
        senderPs: json["sender_ps"],
        status: json["status"],
        sum: json["sum"],
    );

    Map<String, dynamic> toJson() => {
        "commission_sum": commissionSum,
        "operation_time": operationTime,
        "receiver_id": receiverId,
        "receiver_mfo": receiverMfo,
        "receiver_name": receiverName,
        "receiver_pan": receiverPan,
        "receiver_ps": receiverPs,
        "sender_id": senderId,
        "sender_mfo": senderMfo,
        "sender_pan": senderPan,
        "sender_ps": senderPs,
        "status": status,
        "sum": sum,
    };
}
