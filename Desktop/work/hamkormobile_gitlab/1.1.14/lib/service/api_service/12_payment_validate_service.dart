import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/p2p_info_model.dart';
import 'package:mobile/models/p2p_sucses_validate.dart';
import 'package:mobile/models/translations_model.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/routes/router/router.dart';

class PaymentValidateApi {
  static final PaymentValidateApi _instance = PaymentValidateApi._init();
  static PaymentValidateApi get instance => _instance;
  Future postPaymenValidate(ClientCardsModel data1, TransactionModel data2,
      BuildContext context, String amount) async {
    var s = amount.split(
      " ",
    );
    String _amount = "";
    s.forEach(((e) {
      _amount += e;
    }));
    var k = _amount.split("UZS");
    String sum = k[0].trim();
    // k.forEach((e) { sum+=e;});
    var data;
    var _data1 = context.homePr.responseClientCards!.data!.cards![context
        .transactionsPr
        .cardsState]; //data1.data!.cards![context.transactionsPr.cardsState];
    if (context.transactionsPr.transferHomePageData) {
      var homeData = context.transactionsPr.homeData
          .data![context.transactionsPr.homeDataIndex].receiver;

      data = {
        "is_template": true,
        "receiver": {
          "bank_code": homeData!.bankCode.toString(),
          "expire": homeData.expire.toString(),
          "id": homeData.id.toString(),
          "owner": homeData.owner.toString(),
          "pan": homeData.pan.toString(),
          "ps_code": homeData.psCode.toString()
        },
        "sender": {
          "bank_code": _data1.mfo.toString(),
          "expire": _data1.expire.toString(),
          "id": _data1.cardId.toString(),
          "owner": _data1.owner.toString(),
          "pan": _data1.maskNum.toString(),
          "ps_code": _data1.psCode.toString(),
        },
        "sum": int.parse(sum.trim()),
        "template_id": context.transactionsPr.homeData
            .data![context.transactionsPr.homeDataIndex].templateId
            .toString(),
      };
    } else if (context.transactionsPr.transferEmty <= 1) {
      data = {
        "is_template": true,
        "receiver": {
          "bank_code": data2.data![context.transactionsPr.transferCardStare]
              .receiver!.bankCode
              .toString(), // .split("Code.")[1].split("THE_")[1],
          "expire": data2
              .data![context.transactionsPr.transferCardStare].receiver!.expire
              .toString(), // == "Expire.EMPTY"  ? "" :   data2.data![context.transactionsPr.transferCardStare].receiver!.expire.toString(),
          "id": data2
              .data![context.transactionsPr.transferCardStare].receiver!.id
              .toString(),
          "owner": data2
              .data![context.transactionsPr.transferCardStare].receiver!.owner
              .toString(),
          "pan": data2
              .data![context.transactionsPr.transferCardStare].receiver!.pan
              .toString(),
          "ps_code": data2
              .data![context.transactionsPr.transferCardStare].receiver!.psCode
              .toString() //.split("Code.")[1],
        },
        "sender": {
          "bank_code": _data1.mfo.toString(),
          "expire": _data1.expire.toString(),
          "id": _data1.cardId.toString(),
          "owner": _data1.owner.toString(),
          "pan": _data1.maskNum.toString(),
          "ps_code": _data1.psCode.toString(),
        },
        "sum": int.parse(sum.trim()),
        "template_id": data2
            .data![context.transactionsPr.transferCardStare].templateId
            .toString(),
      };
    } else {
      P2PInfoModel p2pInfo = context.transactionsPr.responseP2pInfo;
      data = {
        "is_template": false,
        "receiver": {
          "bank_code": p2pInfo.data!.bankCode
              .toString(), //.split("Code.")[1].split("THE_")[1],
          "expire": p2pInfo.data!.expire
              .toString(), // == "Expire.EMPTY"  ? "" :   data2.data![context.transactionsPr.transferCardStare].commissionSum.receiver!.expire.toString(),
          "id": p2pInfo.data!.cardId.toString(),
          "owner": p2pInfo.data!.owner.toString(),
          "pan": p2pInfo.data!.pan.toString(),
          "ps_code": p2pInfo.data!.processing.toString(), //.split("Code.")[1],
        },
        "sender": {
          "bank_code": _data1.mfo.toString(),
          "expire": _data1.expire.toString(),
          "id": _data1.cardId.toString(),
          "owner": _data1.owner.toString(),
          "pan": _data1.maskNum.toString(),
          "ps_code": _data1.psCode.toString(),
        },
        "sum": int.parse(sum.trim()),
        "template_id": "",
      };
    }

    try {

      final response = await DioClient.instance.post(
        Endpoints.baseUrl + Endpoints.transValidate,
        options: Options(headers: Endpoints.headers()),
        data: data,
      );
      P2PValidateSucsesModel res = P2PValidateSucsesModel.fromJson(response);

      return res;
    } catch (e) {

      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
      }
      throw e;
    }
  }

  PaymentValidateApi._init();
}
