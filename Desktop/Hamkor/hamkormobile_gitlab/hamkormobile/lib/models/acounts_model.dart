// To parse this JSON data, do
//
//     final accountsModel = accountsModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_generator_number.dart';
part 'acounts_model.g.dart';
AccountsModel accountsModelFromJson(String str) =>
    AccountsModel.fromJson(json.decode(str));

String accountsModelToJson(AccountsModel data) => json.encode(data.toJson());

@HiveType(typeId: HiveGeneratorNumber.ACCOUNTS_MODEL)
class AccountsModel {
  AccountsModel({
    this.data,
    this.errorCode,
    this.errorNote,
    this.status,
  });

  @HiveField(0)
  List<AccountsDatum>? data;
  @HiveField(1)
  int? errorCode;
  @HiveField(2)
  String? errorNote;
  @HiveField(3)
  String? status;

  factory AccountsModel.fromJson(Map<String, dynamic> json) => AccountsModel(
        data: List<AccountsDatum>.from(
            json["data"].map((x) => AccountsDatum.fromJson(x))),
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

@HiveType(typeId: HiveGeneratorNumber.ACCOUNTS_DATUM)
class AccountsDatum {
  AccountsDatum({
    this.account,
    this.codeCoa,
    this.codeCurrency,
    this.codeFilial,
    this.condition,
    this.createDate,
    this.id,
    this.nameAcc,
    this.saldo,
  });
  @HiveField(0)
  String? account;
  @HiveField(1)
  String? codeCoa;
  @HiveField(2)
  String? codeCurrency;
  @HiveField(3)
  String? codeFilial;
  @HiveField(4)
  String? condition;
  @HiveField(5)
  String? createDate;
  @HiveField(6)
  String? id;
  @HiveField(7)
  String? nameAcc;
  @HiveField(8)
  String? saldo;

  factory AccountsDatum.fromJson(Map<String, dynamic> json) => AccountsDatum(
        account: json["account"],
        codeCoa: json["code_coa"],
        codeCurrency: json["code_currency"],
        codeFilial: json["code_filial"],
        condition: json["condition"],
        createDate: json["create_date"],
        id: json["id"],
        nameAcc: json["name_acc"],
        saldo: json["saldo"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "code_coa": codeCoa,
        "code_currency": codeCurrency,
        "code_filial": codeFilial,
        "condition": condition,
        "create_date": createDate,
        "id": id,
        "name_acc": nameAcc,
        "saldo": saldo,
      };
}
