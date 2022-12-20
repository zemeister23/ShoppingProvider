import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
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

class _SmsRegisterScreenState extends BaseState<SmsRegisterScreen>
    with WidgetsBindingObserver {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Timer timer;
  late String telNumber;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.smsPr.isSendAgainLoading = false;
    context.smsPr.sendMassageActiv = true;
    context.phoneRegisterPr.clearPhoneNumber();
    context.smsPr.initState(context, widget.smsRegisterPage);
    telNumber = GetStorageService.instance.box
            .read(GetStorageService.instance.uiTelNomer) ??
        "991234567";
  }
    


    
  late SmsProvider _smsProvider;
  late SmsProvider myProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _smsProvider = context.smsPr;
    myProvider = context.smsPr;
  }

  @override
  void dispose() {
    super.dispose();
    GetStorageService.instance.box
        .write(GetStorageService.instance.telNomer, telNumber);
    _smsProvider.disposee();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      context.smsPr.resumeApp();
      setState(() {});
    }
    if (state == AppLifecycleState.paused) {
      context.smsPr.pausedApp();
      setState(() {});
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
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
              formKey: formKey,
              textEditingController: textEditingController,
              smsRegisterPage: widget.smsRegisterPage,
              smsTransactionsPage: false,
              addCardPage: widget.addCartPage,
            ),

            textCapasity(myProvider),
            myProvider.capacity > 0
                ? Text(
                    myProvider.erorText,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: ColorConst.instance.kErrorColor,
                        fontSize: FontSizeConst.instance.small2),
                  )
                : SizedBox(),
            const Spacer(
              flex: 100,
            ),
            Consumer<SmsProvider>(
                builder: (context, themeProvider, child) =>
                    SendAgainTextButton(false, widget.addCartPage))
            // sendMassage(myProvider)
          ],
        ),
      ),
    );
  }

  textCapasity(SmsProvider myProvider) {
    //  myProvider.capacity >= 3

    if (myProvider.capacity > 0) {
      return context.smsPrStream.seconds != 0
          ? Consumer<SmsProvider>(
              builder: (context, themeProvider, child) => Text(
                    "resending_code_after"
                        .locale
                        .replaceAll("SEKUND", " ${myProvider.seconds}"),
                    textAlign: TextAlign.center,
                    style: context.theme.bodyText2,
                  ))
          : Text(
              "sms_expired".locale,
              textAlign: TextAlign.left,
              style: FontstyleText.instance.smsErorTextStyle,
            );
    } else {
      if (context.smsPrStream.minut != 0) {
        return Consumer<SmsProvider>(builder: (context, themeProvider, child) {
          return Text(
            "lockout_time_minutes"
                .locale
                .replaceAll("MINUTES", "${themeProvider.minut}"),
            textAlign: TextAlign.center,
            style: FontstyleText.instance.smsErorTextStyle,
          );
        });
      } else {
        return Text(
          "blocking_time_expired".locale,
          textAlign: TextAlign.center,
          style: FontstyleText.instance.smsErorTextStyle,
        );
      }
    }
  }
}
