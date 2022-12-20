// To parse this JSON data, do
//
//     final p2PTemplatesModel = p2PTemplatesModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_generator_number.dart';
part 'p2p_template_model.g.dart';
P2PTemplatesModel p2PTemplatesModelFromJson(String str) =>
    P2PTemplatesModel.fromJson(json.decode(str));

String p2PTemplatesModelToJson(P2PTemplatesModel data) =>
    json.encode(data.toJson());
@HiveType(typeId: HiveGeneratorNumber.P2PTEMPLATES)
class P2PTemplatesModel {
  P2PTemplatesModel({
    this.data,
    this.errorCode,
    this.errorNote,
    this.status,
  });
  @HiveField(0)
  List<P2pTemplatesDatum>? data;
  @HiveField(1)
  int? errorCode;
  @HiveField(2)
  String? errorNote;
  @HiveField(3)
  String? status;

  factory P2PTemplatesModel.fromJson(Map<String, dynamic> json) =>
      P2PTemplatesModel(
        data: List<P2pTemplatesDatum>.from(
            json["data"].map((x) => P2pTemplatesDatum.fromJson(x))),
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
@HiveType(typeId: HiveGeneratorNumber.P2PTEMPLATES_DATUM)
class P2pTemplatesDatum {
  P2pTemplatesDatum({
    this.commissionSum,
    this.operationTime,
    this.receiver,
    this.sender,
    this.status,
    this.sum,
    this.templateId,
  });

  @HiveField(0)
  num? commissionSum;
  @HiveField(1)
  String? operationTime;
  @HiveField(2)
  P2pReceiver? receiver;
  @HiveField(3)
  P2pReceiver? sender;
  @HiveField(4)
  String? status;
  @HiveField(5)
  num? sum;
  @HiveField(6)
  String? templateId;

  factory P2pTemplatesDatum.fromJson(Map<String, dynamic> json) =>
      P2pTemplatesDatum(
        commissionSum: json["commission_sum"],
        operationTime: json["operation_time"],
        receiver: P2pReceiver.fromJson(json["receiver"]),
        sender: P2pReceiver.fromJson(json["sender"]),
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

@HiveType(typeId: HiveGeneratorNumber.P2PTEMPLATES_RECIVER)
class P2pReceiver {
  P2pReceiver({
    this.bankCode,
    this.expire,
    this.id,
    this.owner,
    this.pan,
    this.psCode,
  });
  @HiveField(0)
  String? bankCode;
  @HiveField(1)
  String? expire;
  @HiveField(2)
  String? id;
  @HiveField(3)
  String? owner;
  @HiveField(4)
  String? pan;
  @HiveField(5)
  String? psCode;

  factory P2pReceiver.fromJson(Map<String, dynamic> json) => P2pReceiver(
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
