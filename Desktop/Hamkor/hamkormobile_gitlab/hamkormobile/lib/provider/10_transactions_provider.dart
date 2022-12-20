import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/p2p_confirm_model.dart';
import 'package:mobile/models/p2p_info_model.dart';
import 'package:mobile/models/p2p_init_model.dart';
import 'package:mobile/models/p2p_sucses_validate.dart';
import 'package:mobile/models/p2p_template_model.dart';
import 'package:mobile/models/transactions_model.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/12_payment_validate_service.dart';
import 'package:mobile/service/api_service/p2p_service/p2p_confirm_api.dart';
import 'package:mobile/service/api_service/p2p_service/p2p_info_api.dart';
import 'package:mobile/service/api_service/p2p_service/p2p_init_api.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/service/api_service/11_transactions_api.dart';
import 'package:mobile/service/auth_service/auth_class.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:provider/provider.dart';

class TransactionsProivder extends ChangeNotifier {
  TextEditingController _textEditingController =
      TextEditingController(text: "123456789");
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController get controllerCard => _textEditingController;
  GlobalKey<FormState> get form => _form;
  TextEditingController _textEditingController2 = TextEditingController();
  GlobalKey<FormState> _formAmount = GlobalKey<FormState>();
  TextEditingController get controllerAmount => _textEditingController2;
  GlobalKey<FormState> get form2 => _formAmount;
  ValidationItem _cardNumber = ValidationItem(null, null);
  ValidationItem get cardNumber => _cardNumber;
  ValidationItem _amount = ValidationItem(null, null);
  ValidationItem get amount => _amount;
  late P2PValidateSucsesModel responseP2pValidate;
  late P2PConfirmModel responseP2pConffirm;
  String summa = "";
  bool summaState = false;
  Color inputColor = ColorConst.instance.kMainTextColor;
  String transactId = "";
  String signId = "";
  int cardsState = 0;
  int transferCardStare = 0;
  int transferEmty = 0;
  bool smsTranlationsPage = false;
  num? commissionSum;
  late P2PInfoModel responseP2pInfo;
  late P2PTemplatesModel responseTranslations;
  String erorText = "";
  bool loading = false;
  num? totalSum;
  bool transferHomePageData = false;
  late P2PTemplatesModel homeData;
  late int homeDataIndex;
  bool status = false;
  bool onChangedClear = false;
  int cartCurrentIndex = 0;
  bool moneyNotCompatible = false;
  int isMinimumTransfer = 0;
  bool isLoading = true;
  bool get isValid {
    if (_amount.value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future onPressButtn(BuildContext context, dynamic t, ClientCardsModel data,
      P2PTemplatesModel data2) async {
    if (controllerAmount.text.length > 2 &&
        int.parse(t) >= 500 &&
        int.parse(t) <= 135000000 &&
        isValid) {
      postPaymentValidate(data, data2, context);
      Provider.of<LockProvider>(context, listen: false).initializeTimer();
    } else {
      if (int.parse(t) <= 500) {
        transferIncompatible(context, true, 1);
      }
      if (int.parse(t) >= 135000000) {
        transferIncompatible(context, true, 3);
      }
      //  if( int.parse(t) >= 500){
      //   transferIncompatible(context, true, 1);

      // }
    }
  }

  void changeCardCurentIndex(int index) {
    cartCurrentIndex = index;
  }

  dispose() {
    transferEmty = 0;
  }

  void initState() {
    controllerAmount.text = "";
    erorText = "";
    commissionSum = null;
    totalSum = null;
    transactId = "";
    signId = "";
    summa = "";
    loading = false;
    transferEmty = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
    });
  }

  transferIncompatible(BuildContext context, bool state, int isMinimum) {
    moneyNotCompatible = state;
    inputColor = state
        ? ColorConst.instance.kErrorColor
        : ColorConst.instance.kMainTextColor;
    isMinimumTransfer = isMinimum;
    notifyListeners();
  }

  changeErorInputColor(bool state, bool isMinimum) {
    inputColor = state
        ? ColorConst.instance.kErrorColor
        : ColorConst.instance.kMainTextColor;
    notifyListeners();
  }

  changeTransferHomePageData(bool state) {
    transferHomePageData = state;
    notifyListeners();
  }

  changeCommisionSum(BuildContext context, ClientCardsModel data) {
    dynamic t = controllerAmount.text.split(" ");
    String transfer = "";
    t.forEach((element) {
      transfer += element;
    });
    t = transfer.split("UZS")[0].trim();
    totalSum = commissionSum! + int.parse(t);

    if (totalSum! > data.data!.cards![cardsState].balance!) {
      erorText = "not_funt_transfer".locale;
    } else {
      erorText = "";
    }
    notifyListeners();
  }

  changeCardNumber(String number) {}
  changeAmount(
      String transferPrice, ClientCardsModel data, BuildContext context) {
    Provider.of<LockProvider>(context, listen: false).initializeTimer();
    if (transferPrice.length == 1 && transferPrice == "0") {
      controllerAmount.clear();
      notifyListeners();
    }
    dynamic t = transferPrice.split(" ");
    String transfer = "";
    t.forEach((element) {
      transfer += element.trim();
    });
    t = transfer.split("UZS")[0].trim();

    if (int.parse(t) > data.data!.cards![cardsState].balance! ||
        int.parse(t) < 500) {
      _amount = ValidationItem(null, null);
    } else {
      moneyNotCompatible = false;
      _amount = ValidationItem(controllerAmount.text, null);
      inputColor = ColorConst.instance.kMainTextColor;
    }
    if (int.parse(t) >= 135000000) {
      transferIncompatible(context, true, 3);
      isMinimumTransfer = 3;
    } else if (data.data!.cards![cardsState].balance! < int.parse(t)) {
      transferIncompatible(context, true, 2);
      isMinimumTransfer = 2;
    }

    notifyListeners();
  }

  changeCardState(int state) {
    cardsState = state;
    notifyListeners();
  }

  changeMask(String v) {
    if (v.length == 4) {}

    notifyListeners();
  }

  changeTransferCard(int state) {
    transferCardStare = state;
    transferEmty = 1;
    notifyListeners();
  }

  Future postPaymentValidate(ClientCardsModel data, P2PTemplatesModel data2,
      BuildContext context) async {
    try {
      if (isValid) {
        responseP2pValidate = await PaymentValidateApi.instance
            .postPaymenValidate(
                data, data2, context, _textEditingController2.text.toString());

        smsTranlationsPage ? null : Navigator.pop(context);

        summa = controllerAmount.text;
        summaState = true;
        transactId = responseP2pValidate.data!.transactId.toString();
        commissionSum = responseP2pValidate.data!.commissionSum!;

        notifyListeners();
        if (smsTranlationsPage) {
          bool state = false;
          context.smsPr.duration.inSeconds == 00 ? state = true : state = false;
          context.smsPr.stopTimer();
          context.smsPr.starttTimer(secund: 60);
          context.smsPr.capacity = 3;

          context.smsPr.erorText = '';
        }
        changeCommisionSum(context, data);
        //  notifyListeners();
      }
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance.postRefreshToken().then(
              (value) async => await postPaymentValidate(data, data2, context));
        }
      }
    }
    return TransactionModel();
  }

  Future postP2pInit(BuildContext context, {bool? isSendAgain = false}) async {
    try {
      changeStatusOfButton();
      P2PInitModel response = await P2pInitApi.instance.postP2pInit(context);
      if (responseP2pValidate.data!.isConfirm == true && !isSendAgain!) {
        // if (smsTranlationsPage) {

        await context.introPr.changeLoadingState(false);
        Navigator.pop(context);
        NavigationService.instance.pushNamed(routeName: "/15_sms_transaction");
        // }
        smsTranlationsPage = false;
      } else {
        SmsProvider myProvider =
            Provider.of<SmsProvider>(context, listen: false);
        myProvider.stopTimer();
        myProvider.starttTimer(secund: 60);
        myProvider.capacity = 3;

        myProvider.erorText = '';
        myProvider.isSendAgainLoading = false;
      }
      signId = response.data!.signId.toString();
      context.loaderOverlay.hide();
    } catch (e) {
      changeStatusOfButton();
      context.loaderOverlay.hide();
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await postP2pInit(context));
        }
        if (e.response!.statusCode == 500) {
          if (e.response!.data["error_code"] == 1036) {
            NavigationService.instance.pushNamedRemoveUntil(
                routeName: NavigationConst.HOME_PAGE_VIEW);
          } else {
            ErrorMessage.instance.translationsEror(
              e.response!.data["error_code"],
              context,
              text: e.response!.data["error_note"],
            );
          }
        }
      }
    }
    return TransactionModel();
  }

  changeLoading(bool state) {
    loading = state;
    notifyListeners();
  }

  changeStatusOfButton() {
    status = !status;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future postPaymentConfirm(BuildContext context, String smsCode) async {
    try {
      changeStatusOfButton();
      if (smsCode == "") {
        responseP2pConffirm = await P2PConfirmApi.instance
            .postPaymentConfirm(context, responseP2pValidate, smsCode);

        Navigator.pop(context);

        context.loaderOverlay.hide();

        await NavigationService.instance.pushNamedRemoveUntil(
          routeName: "/14_sucses_transactions",
        );
        context.smsPr.stopTimer();
      } else if (context.smsPr.seconds != 0) {
        responseP2pConffirm = await P2PConfirmApi.instance
            .postPaymentConfirm(context, responseP2pValidate, smsCode);
        context.loaderOverlay.hide();
        NavigationService.instance.pushNamed(
          routeName: "/14_sucses_transactions",
        );
      } else {
        context.smsPr.stopTimer();
        if (isLoading) {
          isLoading = false;

          context.loaderOverlay.hide();
        }
      }
    } catch (e) {
      changeStatusOfButton();
      context.loaderOverlay.hide();

      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.data["error_code"] == "1036") {
          NavigationService.instance
              .pushNamedRemoveUntil(routeName: NavigationConst.HOME_PAGE_VIEW);
        } else {
          //  ErrorMessage.instance.translationsEror(e.response!.data["error_code"], context);
        }
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance.postRefreshToken().then(
              (value) async => await postPaymentConfirm(context, smsCode));
      }
    }
    return TransactionModel();
  }

  Future<P2PTemplatesModel> getTranlations(BuildContext context) async {
    try {
      responseTranslations = await TranslationsApi.instance.getTranlation();
      return responseTranslations;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 500) {
          if (e.response!.data["error_code"] == "1036") {
            NavigationService.instance.pushNamedRemoveUntil(
                routeName: NavigationConst.HOME_PAGE_VIEW);
          } else {
            ErrorMessage.instance
                .translationsEror(e.response!.data["error_code"], context);
          }
        }

        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getTranlations(context));
      }
    }
    return P2PTemplatesModel();
  }

  Future<P2PInfoModel?> getP2pInfo(
      String cardNumber, BuildContext context) async {
    try {
      responseP2pInfo =
          await P2pInfoApi.instance.getP2pInfo(cardNumber, context);
      controllerAmount.clear();
      commissionSum = null;
      summa = '';
      transferEmty = 3;
      notifyListeners();
      return responseP2pInfo;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getP2pInfo(cardNumber, context));
        }
        if (e.response!.statusCode == 500) {
          ErrorMessage.instance
              .translationsEror(e.response!.data["eror_code"], context);
        }
      }
    }
    return null;
  }
}
