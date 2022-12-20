// To parse this JSON data, do
//
//     final productStoreModel = productStoreModelFromJson(jsonString);
import 'dart:convert';

ProductStoreModel productStoreModelFromJson(String str) => ProductStoreModel.fromJson(json.decode(str));

String productStoreModelToJson(ProductStoreModel data) => json.encode(data.toJson());

class ProductStoreModel {
    ProductStoreModel({
        this.data,
        this.errorCode,
        this.errorNote,
        this.status,
    });

    Data? data;
    int? errorCode;
    String? errorNote;
    String? status;

    factory ProductStoreModel.fromJson(Map<String, dynamic> json) => ProductStoreModel(
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
        this.countOrder,
        this.link,
    });

    int? countOrder;
    String? link;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        countOrder: json["count_order"] == null ? null : json["count_order"],
        link: json["link"] == null ? null : json["link"],
    );

    Map<String, dynamic> toJson() => {
        "count_order": countOrder == null ? null : countOrder,
        "link": link == null ? null : link,
    };
}
