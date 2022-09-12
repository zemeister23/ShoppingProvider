// To parse this JSON data, do
//
//     final accountsModel = accountsModelFromJson(jsonString);

import 'dart:convert';

AccountsModel accountsModelFromJson(String str) => AccountsModel.fromJson(json.decode(str));

String accountsModelToJson(AccountsModel data) => json.encode(data.toJson());

class AccountsModel {
    AccountsModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    List<Datum>? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory AccountsModel.fromJson(Map<String, dynamic> json) => AccountsModel(
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

    String? account;
    String? codeCoa;
    String? codeCurrency;
    String? codeFilial;
    String? condition;
    String? createDate;
    String? id;
    String? nameAcc;
    String? saldo;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
