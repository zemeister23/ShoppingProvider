import 'package:flutter/material.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';

class ErrorWebView {
  static final ErrorWebView _instance = ErrorWebView._init();
  ErrorWebView._init();
  static ErrorWebView get instance => _instance;
  errorWebView(int errorCod, BuildContext context,
      {String? text,
      VoidCallback? onTap,
      bool? isDisable,
      bool? isSmsScreen = false,
      Uri? url,
      }
      
      ) async {
      switch (errorCod) {
      case 10:
        await showDialog(
            context: context,
            builder: (_) {
              return ErrorDialog(
                sizeHeightPainer: 3.2,
                positionTopContainer: 3.23,
                titleDone: true,
                title: "poor_quality_photo".locale,
                subtitle: "correct_camera".locale,
                buttonTextBottom: "try_again_biometry".locale,
                onPressedBottom: onTap ??
                    () {
                      Navigator.pop(_);
                    },
              );
            });
        break;
       case 30:
        await showDialog(
            context: context,
            builder: (_) {
              return ErrorDialog(
                sizeHeightPainer: 3.2,
                positionTopContainer: 3.23,
                titleDone: true,
                title: "poor_quality_photo".locale,
                subtitle: "correct_camera".locale,
                buttonTextBottom: "try_again_biometry".locale,
                onPressedBottom: onTap ??
                    () {
                      Navigator.pop(_);
                    },
              );
            });
        break;  
      case 40:
        await showDialog(
            context: context,
            builder: (_) {
              return ErrorDialog(
                sizeHeightPainer: 3.2,
                positionTopContainer: 3.23,
                titleDone: true,
                title: "t_block".locale,
                subtitle: "bloc_web_view_bio".locale,
                buttonTextBottom: "ok".locale,
                onPressedBottom: onTap ??
                    () {
                     NavigationService.instance.pushNamed(routeName: NavigationConst.VIEW_ADD_CARD_WEB_PAGE,data:url );
                    },
              );
            });
        break;
      default :
        await showDialog(
            context: context,
            builder: (_) {
              return ErrorDialog(
                sizeHeightPainer: 3.2,
                positionTopContainer: 3.23,
                titleDone: true,
                title: "server_error".locale,
                subtitle: "the_server_not_working".locale,
                buttonTextBottom: "ok".locale,
                onPressedBottom: onTap ??
                    () {
                     NavigationService.instance.pushNamed(routeName: NavigationConst.VIEW_ADD_CARD_WEB_PAGE,data:url );
                    },
              );
            });
        break; 
      
      }

      }
      
      }