import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/2_registration_provider.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:mobile/views/3_smscode/sms_code_screen.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class SendAgainTextButton extends StatefulWidget {
  bool smstranlationsPage;
  bool addCardPage;
  SendAgainTextButton(this.smstranlationsPage, this.addCardPage, {Key? key})
      : super(key: key);

  @override
  State<SendAgainTextButton> createState() => _SendAgainTextButtonState();
}

class _SendAgainTextButtonState extends State<SendAgainTextButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SmsProvider myProvider = context.smsPr;

    return sendMassage(myProvider);
  }

  Widget codeBody() {
    return Center(
      child: SafeArea(
        top: false,
        bottom: true,
        child: TextButton(
          onPressed: () async {
            if (!context.smsPr.isSendAgainLoading) {
              context.smsPr.sendMassageActiv = false;
              await context.smsPr
                  .senAgainButton(
                      addCardPage: widget.addCardPage,
                      smstranlationsPage: widget.smstranlationsPage,
                      context: context)
                  .then((value) {
                
              });
            } else {
              
            }
          },
          child: Text(
            "request_code_again".locale,
            style: TextStyle(
              fontSize: 15.sp,
              color: ColorConst.instance.kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget sendMassage(SmsProvider myProvider) {
    if (myProvider.sendMassageActiv && myProvider.minut == 0) {
      myProvider.sendMassageActiv =
          myProvider.seconds == 0 && myProvider.minut == 0 ? false : true;
      return codeBody();
    } else if (myProvider.minut == 0 && myProvider.seconds == 0) {
      return codeBody();
    } else {
      return SizedBox();
    }
  }
}
