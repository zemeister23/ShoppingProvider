 import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';
import 'package:mobile/widgets/new_dialog/alerty_dialog_2.dart';

class MobileErrorAlert {
  static final MobileErrorAlert _instance = MobileErrorAlert._init();
  MobileErrorAlert._init();
  static MobileErrorAlert get instance => _instance;
  mobileErrorAlert(int errorCod, BuildContext context,
      {String? text,
      VoidCallback? onTap,
      bool? isDisable,
      }
      
      ) async {
      switch (errorCod) {
      case 1:
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertyDialog2(
                 positionTopContainer: 3.8,
                sizeHeightPainer: 2.6,
                title: "face_and_touch_not_sistem_title".locale,
                subtitle: AutoSizeText("face_and_touch_not_sistem_subtitle".locale),
                buttonTextBottom: "ok".locale,
                paddingText:10,
                onPressedTop: (){
                  
                    GetStorageService.instance.box
                  .write(GetStorageService.instance.hasFaceTouch, "false");
                  Navigator.pop(context);
                },
                );
          });

       
        break;
      
      }

      }
      
      }
 
  
    