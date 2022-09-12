import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/loading/loading_dialog.dart';
import 'package:provider/provider.dart';
import '../../provider/3_sms_provider.dart';
import '../../widgets/3_smscode/send-again.dart';
import '../../widgets/3_smscode/sms_code_form.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmsRegisterScreen extends StatefulWidget {
  final bool smsRegisterPage;
  final bool addCartPage;
  const SmsRegisterScreen(
    this.smsRegisterPage,
    this.addCartPage, {
    Key? key,
  }) : super(key: key);

  @override
  _SmsRegisterScreenState createState() => _SmsRegisterScreenState();
}

class _SmsRegisterScreenState extends BaseState<SmsRegisterScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Timer timer;
  late String telNumber;

  @override
  void initState() {
    super.initState();
    context.phoneRegisterPr.clearPhoneNumber();
    context.smsPr.initState(context, widget.smsRegisterPage);
    telNumber = GetStorageService.instance.box
            .read(GetStorageService.instance.uiTelNomer) ??
        "991234567";
  }

  late SmsProvider _smsProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _smsProvider = context.smsPr;
  }

  @override
  @override
  void dispose() {
    super.dispose();
    GetStorageService.instance.box
        .write(GetStorageService.instance.telNomer, telNumber);
    _smsProvider.disposee();
  }

  @override
  Widget build(BuildContext context) {
    // final myProvider =  context.select((SmsProvider foo) => foo);
    SmsProvider myProvider = context.watch<SmsProvider>();
    return Scaffold(
      appBar: DefaultAppbar.getAppBar(null, null, context, true),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConst.instance.horizPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 32.h,
            ),
            Text("registration".locale, style: context.theme.headline1),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "enter_the_code".locale.replaceAll("NUMBER", "+998 $telNumber"),
              style: context.theme.subtitle2,
            ),
            SizedBox(
              height: 23.h,
            ),
            SmsCodeForm(
              formKey,
              textEditingController,
              widget.smsRegisterPage,
              false,
            ),
            myProvider.capacity >= 3
                ? Consumer<SmsProvider>(
                    builder: (context, themeProvider, child) => Text(
                          "resending_code_after".locale +
                              " 00:${myProvider.seconds}",
                          textAlign: TextAlign.center,
                          style: context.theme.bodyText2,
                        ))
                : const SizedBox(),
            myProvider.capacity > 0
                ? Text(
                    myProvider.erorText,
                    style: TextStyle(
                        color: ColorConst.instance.kErrorColor,
                        fontSize: FontSizeConst.instance.small2),
                  )
                : SizedBox(),
            const Spacer(
              flex: 100,
            ),
            myProvider.textCapasity <= 0
                ? const SizedBox()
                : SendAgainTextButton(false, widget.addCartPage),
          ],
        ),
      ),
    );
  }
}
