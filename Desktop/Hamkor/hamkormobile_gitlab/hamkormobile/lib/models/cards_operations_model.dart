// To parse this JSON data, do
//
//     final cardsOperationsModel = cardsOperationsModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_adapter_service.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_generator_number.dart';
part 'cards_operations_model.g.dart';
CardsOperationsModel cardsOperationsModelFromJson(String str) =>
    CardsOperationsModel.fromJson(json.decode(str));
@HiveType(typeId: HiveGeneratorNumber.CARDS_OPERATIONS)
class CardsOperationsModel {
  CardsOperationsModel({
    this.data,
    this.errorCode,
    this.errorNote,
    this.status,
  });
 
  @HiveField(0)
  List<StoryDatum>? data;
   @HiveField(1)
  int? errorCode;
   @HiveField(2)
  String? errorNote;
   @HiveField(3)
  String? status;

  factory CardsOperationsModel.fromJson(Map<String, dynamic> json) =>
      CardsOperationsModel(
        data: List<StoryDatum>.from(
            json["data"].map((x) => StoryDatum.fromJson(x))),
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
      );
}
@HiveType(typeId: HiveGeneratorNumber.CARDS_OPERATIONS_DATUM)
class StoryDatum {
  StoryDatum({
    this.cardId,
    this.health,
    this.operations,
  });
  
   @HiveField(0)
  String? cardId;
   @HiveField(1)
  bool? health;
   @HiveField(2)
  List<HistoryOperation>? operations;

  factory StoryDatum.fromJson(Map<String, dynamic> json) => StoryDatum(
        cardId: json["card_id"],
        health: json["health"],
        operations: List<HistoryOperation>.from(
            json["operations"].map((x) => HistoryOperation.fromJson(x))),
      );
}
@HiveType(typeId: HiveGeneratorNumber.CARDS_OPERATIONS_OPERATIONS)
class HistoryOperation {
  HistoryOperation({
    this.amount,
    this.city,
    this.country,
    this.currencyCode,
    this.feeAmount,
    this.maskPan,
    this.mccCode,
    this.merchantName,
    this.operationDay,
    this.operationTime,
    this.operationType,
    this.orgCode,
    this.psCode,
    this.reversal,
    this.rrn,
    this.street,
    this.terminalId,
    this.transactionId,
  });
 @HiveField(0)
  int? amount;
   @HiveField(1)
  String? city;
   @HiveField(2)
  String? country;
   @HiveField(3)
  String? currencyCode;
   @HiveField(4)
  int? feeAmount;
   @HiveField(5)
  String? maskPan;
   @HiveField(6)
  String? mccCode;
   @HiveField(7)
  String? merchantName;
   @HiveField(8)
  String? operationDay;
   @HiveField(9)
  String? operationTime;
   @HiveField(10)
  int? operationType;
   @HiveField(11)
  String? orgCode;
   @HiveField(12)
  String? psCode;
   @HiveField(13)
  bool? reversal;
   @HiveField(14)
  String? rrn;
   @HiveField(15)
  String? street;
   @HiveField(16)
  String? terminalId;
   @HiveField(17)
  String? transactionId;

  factory HistoryOperation.fromJson(Map<String, dynamic> json) => HistoryOperation(
        amount: json["amount"],
        city: json["city"],
        country: json["country"],
        currencyCode: json["currency_code"],
        feeAmount: json["fee_amount"],
        maskPan: json["mask_pan"],
        mccCode: json["mcc_code"],
        merchantName: json["merchant_name"],
        operationDay: json["operation_day"],
        operationTime: json["operation_time"],
        operationType: json["operation_type"],
        orgCode: json["org_code"],
        psCode: json["ps_code"],
        reversal: json["reversal"],
        rrn: json["rrn"],
        street: json["street"],
        terminalId: json["terminal_id"],
        transactionId: json["transaction_id"],
      );
}
