import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/components/text/text_style.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/store_action_model.dart';
import 'package:mobile/provider/1_intro_provider.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/8_razvilka/razvilka_screen.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';
import 'package:mobile/widgets/new_dialog/alerty_dialog_2.dart';
import 'package:mobile/widgets/new_dialog/user_block_error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorMessage {
  static final ErrorMessage _instance = ErrorMessage._init();
  ErrorMessage._init();
  static ErrorMessage get instance => _instance;
  translationsEror(int errorCod, BuildContext context,
      {String? text,
      VoidCallback? onTap,
      bool? isDisable,
      bool? isSmsScreen = false}) async {
    switch (errorCod) {
      
      case 111:
        await showDialog(
            context: context,
            builder: (_) {
              return ErrorDialog(
                sizeHeightPainer: 3.2,
                positionTopContainer: 3.23,
                titleDone: false,
                title: "".locale,
                subtitle: "request_code_again".locale,
                buttonTextBottom: "yes".locale,
                onPressedBottom: onTap ??
                    () {
                      Navigator.pop(_);
                    },
              );
            });
        break;
      
      case 1039:
        await showDialog(
            context: context,
            builder: (_) {
              return AlertyDialog2(
                paddingText: 11.5,
                sizeHeightPainer: 3.2,
                positionTopContainer: 3.4,
                titleDone: false,
                title: "".locale,
                subtitle: AutoSizeText("you_can_not_transfer".locale),
                buttonTextBottom: "ok".locale,
                onPressedBottom: onTap ??
                    () {
                      Navigator.pop(_);
                    },
              );
            });
        break;
     case 1027:
    await showDialog(
         barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertyDialog2(
               
                  positionTopContainer: 3.49,
                 sizeHeightPainer: 2.99,
                title: "",
                subtitle: AutoSizeText("10_27_update_app".locale),
                buttonTextBottom: "update".locale,
                onPressedTop: (){
                  final Uri _url = Platform.isAndroid
                    ? Uri.parse(
                        'https://play.google.com/store/apps/details?id=com.hamkorbank.mobile')
                    : Uri.parse(
                        'https://apps.apple.com/uz/app/hamkor/id1602323485');
                _launchUniversalLinkIos(_url);
                
                
                },
                paddingText: 9.1,
                canGoBack: false,
                );
          });
     break;
      case 1020:
       showDialog(
            context: context,
            builder: (context) {
              String _text = text == null ? "15" : text;
              _text = _text.toString().split(".").first;
              _text = int.parse(_text) < 1 ? "1" : _text;
              

              return BlockDialog(
                  isSmsScreen: isSmsScreen!,
                  sizeHeightPainer: 3.2,
                  positionTopContainer: 3.4,
                  title: "".locale,
                   subtitle: "block_phone".locale.replaceAll("20", _text),
                  buttonTextBottom: "ok".locale,
                  onPressedBottom: onTap ??
                      () {
                        Navigator.pop(context);
                      });
            });

        break;
        case 1022:
       showDialog(
            context: context,
            builder: (context) {
              String _text = text == null ? "15" : text;
              _text = _text.toString().split(".").first;
              _text = int.parse(_text) < 1 ? "1" : _text;
              

              return BlockDialog(
                  isSmsScreen: isSmsScreen!,
                  sizeHeightPainer: 3.2,
                  positionTopContainer: 3.4,
                  title: "".locale,
                   subtitle: "sms_is_not_active".locale,
                  buttonTextBottom: "ok".locale,
                  onPressedBottom: onTap ??
                      () {
                        Navigator.pop(context);
                      });
            });

        break;
      case 1004:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  sizeHeightPainer: 2.9,
                  positionTopContainer: 3.7,
                  titleDone: false,
                  title: "".locale,
                  subtitle: "failed_to_send_SMS".locale,
                  buttonTextBottom: "number".locale,
                  onPressedBottom: () {
                    NavigationService.instance.pushNamedRemoveUntil(
                        routeName: NavigationConst.INTRO_PAGE_VIEW);
                  });
            });

        break;
      case 1019:
        showDialog(
            context: context,
            builder: (context) {
              String _text = text == null ? "15" : text;
              _text = _text.toString().split(".").first;
              _text = int.parse(_text) < 1 ? "1" : _text;
              

              return BlockDialog(
                  isSmsScreen: isSmsScreen!,
                  sizeHeightPainer: 3.2,
                  positionTopContainer: 3.4,
                  title: "".locale,
                   subtitle: "block_phone".locale.replaceAll("20", _text),
                  buttonTextBottom: "ok".locale,
                  onPressedBottom: onTap ??
                      () {
                        Navigator.pop(context);
                      });
            });

        break;
      case 1021:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  sizeHeightPainer: 3.2,
                  positionTopContainer: 3.4,
                  titleDone: false,
                  title: "".locale,
                  subtitle: "sms_code_expired".locale,
                  buttonTextBottom: "ok".locale,
                  onPressedBottom: () {
                    context.addCardPr.cardExpireController.clear();
                    context.addCardPr.cardNumberController.clear();

                    Navigator.pop(context);
                  });
            });

        break;
      case 1029:
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
                positionTopContainer: 3.5,
                sizeHeightPainer: 2.8,
                titleDone: true,
                issubtitleWidget: true,
                subtitleWidget: text1029(),
                title: "verification_invalid_data".locale,
                subtitle: "please_report_problem".locale,
                buttonTextBottom: "ok".locale);
          },
        );
      
      
        break;

      
      case 1030:
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
               // positionTopContainer: ,
              //  sizeHeightPainer: 102,
                title: "",
                titleDone: false,
                issubtitleWidget: true,
                subtitleWidget: alertText(),
                subtitle: "",
                buttonTextBottom: "ok".locale);
          },
        );
        break;
      case 1005:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                titleDone: false,
                  title: "",
                  subtitle: "check_and_retry_sms".locale,
                  buttonTextBottom: "ok".locale);
            });
        break;
      case 1023:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                titleDone: false,
                  title: "",
                  subtitle: "Сумма меньше чем минимум лимит",
                  buttonTextBottom: "ok".locale);
            });
        break;
      case 1001:
        showDialog(
            context: context,
            builder: (context) {
              
              return ErrorDialog(
                titleDone: false,
                title: "",
                subtitle: "try_again_message".locale,
                buttonTextBottom: "ok".locale,
                onPressedTop: () async {
                  Navigator.pop(context);
                },
              );
            });
        break;
      case 1015:
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
                positionTopContainer: 3.5,
                sizeHeightPainer: 2.8,
                titleDone: false,
                issubtitleWidget: true,
                subtitleWidget: text1015(),
                title: "".locale,
                subtitle: "".locale,
                buttonTextBottom: "ok".locale);
          },
        );
      break;
      case 1011:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  title: "card_not_found_title".locale,
                  subtitle: "card_not_found_message".locale,
                  buttonTextBottom: "ok".locale);
            });
        break;
      case 1033:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  title: "",
                  subtitle: "Операция временно не разрешена(при переводе)",
                  buttonTextBottom: "ok".locale);
            });
        break;
      case 1024:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  title: "",
                  subtitle: "Maximal sum (test)",
                  buttonTextBottom: "ok".locale);
            });
        break;
      case 1013:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  title: "",
                  subtitle: "Ошибка при инициации перевода",
                  buttonTextBottom: "ok".locale);
            });
        break;
      case 1028:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                title: "poor_quality_photo".locale,
                subtitle: "correct_camera".locale,
                buttonTextBottom: "retry2".locale,
                onPressedBottom: () {
                  availableCameras().then((value) async {
                    NavigationService.instance.pushNamed(
                      routeName: NavigationConst
                          .AFTER_RAZVILKA_BIOMETRIC_CAMERA_ANDROID,
                      data: value,
                    );
                  });
                },
              );
            });
        break;
     
      
      case 1031:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                title: "data_not_found".locale,
                subtitle: "contact_to_branch".locale,
                buttonTextBottom: "ok".locale,
                titleDone: true,
                onPressedBottom: () {
                  if (GetStorageService.instance.box
                          .read(GetStorageService.instance.isRazvilkaPage) !=
                      null) {
                    if (GetStorageService.instance.box
                            .read(GetStorageService.instance.isRazvilkaPage) ==
                        "true") {
                      NavigationService.instance.pushNamedRemoveUntil(
                          routeName: NavigationConst.RAZVILKA_PAGE_VIEW);
                    } else {
                      NavigationService.instance.pushNamedRemoveUntil(
                          routeName: NavigationConst.RAZVILKA_PAGE_VIEW);
                    }
                  }
                },
              );
            });
        break;
      case 1038:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                onPressedBottom: () {
                  Navigator.pop(context);
                //  Navigator.pop(context);
                },
                title: "",
                subtitle: "text_1038".locale,
                buttonTextBottom: "try_again_biometry".locale,
              );
            });
        break;
      case 1032:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                title: "t_block".locale,
                subtitle: "registration_blocked".locale,
                buttonTextBottom: "ok".locale,
              );
            });

        break;

      case 102:
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertyDialog2(
              paddingText: 9.5,
              title: "",
              subtitle: AutoSizeText("must_be_updated_message".locale),
              buttonTextBottom: "min_version_update".locale,
              onPressedTop: () {
                final Uri _url = Platform.isAndroid
                    ? Uri.parse(
                        'https://play.google.com/store/apps/details?id=com.hamkorbank.mobile')
                    : Uri.parse(
                        'https://apps.apple.com/uz/app/hamkor/id1602323485');
                _launchUniversalLinkIos(_url);
              },
              onPressedBottom: () {},
            );
          },
        );
        break;
      case 99999:
        showDialog(
          context: context,
          builder: (context) {
            return AlertyDialog2(
              titleDone: true,
              paddingText: 9.5,
              title: "card_not_be_same".locale,
              subtitle: AutoSizeText("card_not_be_same_message".locale),
              buttonTextBottom: "ok".locale,
            );
          },
        );

        break;
      case 1021:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  sizeHeightPainer: 3.2,
                  positionTopContainer: 3.4,
                  titleDone: false,
                  title: "".locale,
                  subtitle: "sms_code_expired".locale,
                  buttonTextBottom: "ok".locale,
                  onPressedBottom: () {
                    context.addCardPr.cardExpireController.clear();
                    context.addCardPr.cardNumberController.clear();

                    Navigator.pop(context);
                  });
            });

        break;
      case 1006:
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              sizeHeightPainer: 2.2,
              positionTopContainer: 4.45,
              titleDone: false,
              title: "".locale,
              subtitle: "if_not_uzcard_1".locale,
              buttonTextBottom: "order".locale,
              buttonTextTop: "have_uzcard".locale,
              onPressedBottom: () async {
                context.loaderOverlay.show();
                Provider.of<RazvilkaProvider>(context, listen: false)
                    .getStoreAction(context)
                    .then((value) async {
                  context.loaderOverlay.hide();
                  Uri toLaunch;
                  toLaunch = await value.data!.link == null
                      ? Uri.parse("")
                      : Uri.parse(value.data!.link.toString());
                  await WebViewRoute(value, toLaunch, context);
                });

                context.addCardPr.cardExpireController.clear();
                context.addCardPr.cardNumberController.clear();
                Navigator.pop(context);
              },
              onPressedTop: () async {
                context.addCardPr.cardExpireController.clear();
                context.addCardPr.cardNumberController.clear();
                Navigator.pop(context);
              },
            );
          },
        );
        break;

      // carda xato bosa xumo bosa
      case 1007:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  titleDone: true,
                  title: "card_blocked".locale,
                  subtitle: "get_support".locale,
                 buttonTextBottom: "ok".locale);
            });
        break;
      case 1008:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                sizeHeightPainer: 2.4,
                positionTopContainer: 4.1,
                titleDone: true,
                title: "does_not_match_title".locale,
                subtitle: "does_not_match_message".locale,
                buttonTextBottom: "change_card_number".locale,
                buttonTextTop: "change_phone_number".locale,
                onPressedTop: () async {
                  await Provider.of<IntroProvider>(context, listen: false)
                      .exitApp(context);
                  NavigationService.instance
                      .pushNamedRemoveUntil(routeName: "/1_intro");
                },
              );
            });

        break;

      // case 1001:
      //   //gatov
      //   // cart block
      //   showDialog(
      //       context: context,
      //       builder: (context) {
      //         return ErrorDialog(
      //           sizeHeightPainer: 3,
      //           positionTopContainer: 3.5,
      //           titleDone: false,
      //           title: "",
      //           subtitle: "try_again_message".locale + "...",
      //           buttonTextBottom: "retry".locale,
      //         );
      //       });

      //   context.addCardPr.erorMessage = "";
     //   break;
      case 1011:
        context.addCardPr.changeCardBlock();
        
        if (GetStorageService.instance.box
                .read(GetStorageService.instance.blockCapacity) ==
            "1") {
          context.addCardPr.blockCapacity = 3;
          showDialog(
            context: context,
            builder: (context) {
              return AlertyDialog2(
                paddingText: 9.5,
                title: "card_not_found_title".locale,
                subtitle: AutoSizeText("card_not_found_message".locale),
                buttonTextBottom: "ok".locale,
              );
            },
          );
        } else {
          GetStorageService.instance.box.write(
              GetStorageService.instance.blockCapacity,
              "${context.addCardPr.blockCapacity}");
          showDialog(
              context: context,
              builder: (context) {
                return ErrorDialog(
                    titleDone: true,
                    positionTopContainer: 3.32,
                    sizeHeightPainer: 3.2,
                    title: "card_not_found_title".locale,
                    subtitle: "card_not_found_message".locale,
                    buttonTextBottom: "ok".locale);
              });
        }
        break;
      default:
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                titleDone: false,
                title: "",
                subtitle: "default".locale,
                buttonTextBottom: "ok".locale,
                onPressedTop: () async {
                  Navigator.pop(context);
                  //  await NavigationService.instance
                  //     .pushNamedRemoveUntil(routeName: "/home");
                },
              );
            });
        break;
    }
  }


  alertText() {
    return AutoSizeText.rich(
      TextSpan(
        text: "check_number_message".locale,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: FontSizeConst.instance.bottom,
          color: ColorConst.instance.kSecondaryTextColor,
        ),
        children: [
          TextSpan(
            text: " " + "telegram_link".locale,
            style: TextStyle(
              fontSize: FontSizeConst.instance.small,
              color: ColorConst.instance.kErrorColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchUniversalLinkIos(_url);
              },
          ),
         
          TextSpan(
            text: " " + "check_number_message_1".locale,
            style: TextStyle(
              fontSize: FontSizeConst.instance.small,
              color: ColorConst.instance.kSecondaryTextColor,
            ),
          )
        ],
      ),
      textAlign: TextAlign.center,
      minFontSize: 1,
      maxFontSize: 17,
    );
  }

  final Uri _url = Uri.parse('https://t.me/ConsultHamkorbankBot');

  Future<void> _launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

text1029(){
  return AutoSizeText.rich(
      textAlign: TextAlign.center,
      minFontSize: 1,
      maxFontSize: 17,
    TextSpan(
      children: [
        TextSpan(
        style: TextStyleCompanents.instance.alertTextStyle,
        text:  "please_report_problem".locale),
          TextSpan(
            text: " " + "link_bot".locale,
            style: TextStyleCompanents.instance.alertErrorTextStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchUniversalLinkIos(_url);
              },
          ),
       TextSpan(
        style: TextStyleCompanents.instance.alertTextStyle,
        text:  "please_report_problem_2".locale),   
      ]
    )
  );

  
}
  

text1015(){
  return AutoSizeText.rich(
      textAlign: TextAlign.center,
      minFontSize: 1,
      maxFontSize: 17,
    TextSpan(
      children: [
        TextSpan(
        style: TextStyleCompanents.instance.alertTextStyle,
        text:  "10_15_error_1".locale),
          TextSpan(
            text: " " + "link_bot".locale,
            style: TextStyleCompanents.instance.alertErrorTextStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchUniversalLinkIos(_url);
              },
          ),
       TextSpan(
        style: TextStyleCompanents.instance.alertTextStyle,
        text:  " "+  "10_15_error_2".locale),   
      ]
    )
  );
}
}
