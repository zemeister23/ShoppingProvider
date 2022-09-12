import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/2_registration_provider.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:provider/provider.dart';
import '../../provider/3_sms_provider.dart';
import '../../provider/check_pass_code_provider.dart';
import '../../widgets/3_smscode/send-again.dart';
import '../../widgets/3_smscode/sms_code_form.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';

class SmsTransactionsScreen extends StatefulWidget {
  const SmsTransactionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SmsTransactionsScreenState createState() => _SmsTransactionsScreenState();
}

class _SmsTransactionsScreenState extends BaseState<SmsTransactionsScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Timer timer;
  late String telNumber;

  @override
  void initState() {
    super.initState();
    Provider.of<CheckPassCodeProvider>(context, listen: false)
        .changeIsPopToTrue;
    context.smsPr.initState(context, false);
    telNumber = GetStorageService.instance.box
        .read(GetStorageService.instance.uiTelNomer);
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

    _smsProvider.stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    SmsProvider myProvider = context.watch<SmsProvider>();
    return Scaffold(
      appBar: DefaultAppbar.getAppBar(null, null, context, true),
      body: context.transactionsPr.loading
          ? LoadingPage(true)
          : GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.h * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(flex: 3),
                    Text("p2p_sms".locale, style: context.theme.headline1),
                    const Spacer(flex: 7),
                    Text(
                      "+998 " +
                          telNumber +
                          " " +
                          "enter_the_code".locale.replaceAll("NUMBER", ""),
                      style: context.theme.subtitle2,
                    ),
                    const Spacer(flex: 5),
                    SmsCodeForm(formKey, textEditingController, false, true),
                    myProvider.capacity >= 3
                        ? Text(
                            "resending_code_after".locale +
                                " 00:${context.smsPr.seconds}",
                            textAlign: TextAlign.center,
                            style: context.theme.bodyText2,
                          )
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
                        : SendAgainTextButton(true, false),
                  ],
                ),
              ),
            ),
    );
  }
}
