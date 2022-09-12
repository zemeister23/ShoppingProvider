import 'package:flutter/material.dart';
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
    return Center(
      child: SafeArea(
        top: false,
        bottom: true,
        child: TextButton(
          onPressed: () async {
          //  if (context.smsPr.capacity > 0) {
              context.smsPr.textButtonActiv();

              if (widget.smstranlationsPage) {
                context.transactionsPr.smsTranlationsPage = true;
                context.transactionsPr.postPaymentValidate(
                    context.homePr.responseClientCards!,
                    context.transactionsPr.responseTranslations,
                    context);
              } else {
                if (widget.addCardPage) {
                  context.addCardPr.postCard(context, true);
                } else {
                  await context.phoneRegisterPr.postPhoneNumberSendAgain(
                   GetStorageService.instance.box.read(GetStorageService.instance.uiTelNomer),
                    context,
                  );
                }
              }
         //   } else {
        //   ErrorMessage.instance.translationsEror(1029, context);
        //    }
          },
          child: Text(
            "request_code_again".locale,
            style: TextStyle(
              fontSize: 15,
              color: ColorConst.instance.kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  

}
