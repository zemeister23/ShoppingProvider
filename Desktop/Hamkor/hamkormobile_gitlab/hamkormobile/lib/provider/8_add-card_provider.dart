import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/add_card_model.dart';
import 'package:mobile/models/product_store.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/10_product_store_service.dart';
import 'package:mobile/service/api_service/9_add_card_service.dart';
import 'package:mobile/service/auth_service/auth_class.dart';
import 'package:provider/provider.dart';
import '../core/constants/navigation/navigation_constant.dart';

class AddCardProvider extends ChangeNotifier {
  late AddCardModel _data;
  late final ProductStoreModel response;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpireController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ValidationItem _cardNumber = ValidationItem(null, null);
  ValidationItem get cardNumber => _cardNumber;
  ValidationItem _cardExpire = ValidationItem(null, null);
  ValidationItem get cardExpiree => _cardExpire;
  final focus = FocusNode();
  AddCardModel get data => _data;
  bool erorColorState = false;
  String erorMessage = "";
  String year = "";
  String month = "";
  bool loading = false;
  int blockCapacity = 3;
  bool buttonOpacity = false;
  bool get isValid {
    if (_cardNumber.value != null && _cardExpire.value != null) {
      return true;
    } else {
      return false;
    }
  }

  changeOpasity() {
    if (cardNumberController.text.length >= 19 &&
        cardExpireController.text.length >= 5) {
      buttonOpacity = true;
      
    } else {
      buttonOpacity = false;
      
    }
    notifyListeners();
  }

  changeColor(bool value) {
    erorColorState = value;

    notifyListeners();
  }

  changeCardBlock() {
    blockCapacity = blockCapacity - 1;
    GetStorageService.instance.box
        .write(GetStorageService.instance.blockCapacity, "$blockCapacity");

    notifyListeners();
  }

  changeCardNumber(String value, BuildContext context) {
    if (value.length >= 19) {
      FocusScope.of(context).requestFocus(focus);
      _cardNumber = ValidationItem(value, null);
    } else {
      _cardNumber = ValidationItem(null, null);
    }
    notifyListeners();
  }

  int _inputMonth = 0;
  int _inputyear = 0;
  changeCardExpire(String value) {
    List _list = [];
    _list.add(value);

    
    _list[0].toString().length >= 2
        ? _inputMonth = int.parse(_list[0][0] + _list[0][1])
        : 1;

    _list[0].toString().length >= 5
        ? _inputyear = int.parse(_list[0][3] + _list[0][4])
        : 1;

    if (_inputMonth < 13 &&
        value.length == 5 &&
        _inputyear >= int.parse(year)) {
      if (_inputyear == int.parse(year)) {
        if (int.parse(month) > _inputMonth) {
          _cardExpire = ValidationItem(null, null);
          changeColor(true);
          erorMessage = "card_incorrect";
        } else {
          _cardExpire = ValidationItem(value, null);
          changeColor(false);
          erorMessage = "";
        }
      } else {
        _cardExpire = ValidationItem(value, null);
        changeColor(false);
        erorMessage = "";
      }
    } else {
      _cardExpire = ValidationItem(null, null);
      changeColor(true);
      erorMessage = "card_incorrect";
    }
    notifyListeners();
  }

  dateTime() {
    var now = DateTime.now();
    year = '';
    month = '';
    var formatter = DateFormat('yyyy-MM-dd');

    String formattedDate = formatter.format(now);
    
    for (var i = 0; i < 7; i++) {
      if (i == 2 || i == 3) {
        year += formattedDate[i];
      }
      if (i == 5 || i == 6) {
        
        month += formattedDate[i];
      }
    }
  }

  Future<void> postCard(BuildContext context, bool isSendAgain) async {
    
    SmsProvider myProvider =
        await Provider.of<SmsProvider>(context, listen: false);
    try {
      if (isValid) {
        final AddCardModel response = await AddCardApi.instance
            .postCard(cardNumberController, cardExpireController, context);
        _data = response;
        if (_data.errorCode == 0) {
          GetStorageService.instance.box
              .write(GetStorageService.instance.signId, _data.data!.signId);
          
          if (!isSendAgain) {
            
            if (_data.data!.confirmMethod!.trim() == "SMS") {
              context.loaderOverlay.hide();
              NavigationService.instance.pushNamed(
                routeName:
                    NavigationConst.ADD_CARD_SMS_CODE_REGISTRATION_PAGE_VIEW,
              );
            } else {
              context.loaderOverlay.hide();
              NavigationService.instance.pushNamed(
                routeName: NavigationConst.AFTER_RAZVILKA_ABIOMETRIC_FIRST,
                data: false,
              );
            }
          } else {
            //  myProvider.duration.inSeconds == 00 ? state = true : state = false;
            myProvider.stopTimer();
            myProvider.starttTimer(secund: 60);
            myProvider.capacity = 3;
            
            myProvider.erorText = '';
            myProvider.isSendAgainLoading = false;
            
            
          }
        }
      }
    } catch (e) {
      

      context.loaderOverlay.hide();
      throw e;
    }
  }

  Future<ProductStoreModel> getProductStore(BuildContext context) async {
    try {
      response = await ProductStoreApi.instance.getProductStore(context);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
