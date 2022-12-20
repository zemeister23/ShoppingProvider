import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import '../../widgets/3_smscode/send-again.dart';
import '../../widgets/3_smscode/sms_code_form.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';

class SmsCode extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController _controller;
  final String telNomer;
  final bool registerPage;
  const SmsCode(
      this.formKey, this._controller, this.telNomer, this.registerPage,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    

    

    

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.h * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Spacer(
              flex: 3,
            ),
            Text("registration".locale, style: context.theme.headline1),
            const Spacer(
              flex: 7,
            ),
            Text(
              "+998 " + telNomer + " " + "enter_the_code".locale,
              style: context.theme.subtitle2,
            ),
            const Spacer(
              flex: 5,
            ),
            const Spacer(
              flex: 100,
            ),
            SendAgainTextButton(false, false),
          ],
        ),
      ),
    );
  }
}
