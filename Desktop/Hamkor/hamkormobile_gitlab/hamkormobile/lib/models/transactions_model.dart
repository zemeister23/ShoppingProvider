// To parse this JSON data, do
//
//     final TransactionModel = TransactionModelFromJson(jsonString);
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_generator_number.dart';
part 'transactions_model.g.dart';
TransactionModel TransactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String TransactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

@HiveType(typeId: HiveGeneratorNumber.TRANSACTIONS)
class TransactionModel {
  TransactionModel({
    this.data,
    this.errorCode,
    this.errorNote,
    this.status,
  });

  @HiveField(0)
  List<TransactionsDatum>? data;
  @HiveField(1)
  int? errorCode;
  @HiveField(2)
  String? errorNote;
  @HiveField(3)
  String? status;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        data: List<TransactionsDatum>.from(
            json["data"].map((x) => TransactionsDatum.fromJson(x))),
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

@HiveType(typeId: HiveGeneratorNumber.TRANSACTIONS_DATUM)
class TransactionsDatum {
  TransactionsDatum({
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
  Receiver? receiver;
  @HiveField(3)
  Receiver? sender;
  @HiveField(4)
  String? status;
  @HiveField(5)
  num? sum;
  @HiveField(6)
  String? templateId;

  factory TransactionsDatum.fromJson(Map<String, dynamic> json) =>
      TransactionsDatum(
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
@HiveType(typeId: HiveGeneratorNumber.TRANSACTIONS_RECIVER)
class Receiver {
  Receiver({
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
