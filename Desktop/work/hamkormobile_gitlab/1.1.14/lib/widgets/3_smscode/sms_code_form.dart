import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmsCodeForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController textEditingController;
  final bool smsRegisterPage;
  final bool smsTransactionsPage;

  SmsCodeForm(this.formKey, this.textEditingController, this.smsRegisterPage,
      this.smsTransactionsPage,
      {Key? key})
      : super(key: key);

  @override
  State<SmsCodeForm> createState() => _SmsCodeFormState();
}

class _SmsCodeFormState extends State<SmsCodeForm> {
  Color erorColor = ColorConst.instance.kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    SmsProvider myProvider = Provider.of<SmsProvider>(context, listen: false);
    SmsProvider myListenProvider = context.watch<SmsProvider>();

    return Form(
      key: widget.formKey,
      child: PinCodeTextField(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        appContext: context,
        autoFocus: true,
        animationType: AnimationType.none,
        keyboardType: TextInputType.number,
        controller: widget.textEditingController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        autoDismissKeyboard: false,
        enableActiveFill: true,
        animationDuration: const Duration(milliseconds: 100),
        textStyle: TextStyle(
            color: myListenProvider.erorColor
                ? ColorConst.instance.kErrorColor
                : ColorConst.instance.kMainTextColor,
            fontSize: FontSizeConst.instance.mainPageUZSSize,
            fontWeight: FontWeight.w600
            //
            ),
        cursorColor: ColorConst.instance.kPrimaryColor,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          borderWidth: 5,
          errorBorderColor: ColorConst.instance.kErrorColor,
          fieldHeight: 58.h,
          fieldWidth: 49.w,
          activeFillColor: ColorConst.instance.kInputColor,
          inactiveFillColor: ColorConst.instance.kInputColor,
          selectedFillColor: ColorConst.instance.kInputColor,
          activeColor: myListenProvider.activColor(),
          inactiveColor: ColorConst.instance.kPrimaryColor.withOpacity(0.5),
          selectedColor: ColorConst.instance.kPrimaryColor,
        ),
        length: 6,
        onChanged: (value) {
          Provider.of<LockProvider>(context, listen: false).initializeTimer();
          myProvider.erorTextState(false);
          myProvider.changsSms(value);
        },
        onCompleted: (v) async {
          FocusScope.of(context).unfocus();
          if (widget.smsTransactionsPage) {
            context.loaderOverlay.show();
            context.transactionsPr.postPaymentConfirm(context, v);
          } else {
            context.loaderOverlay.show();
            await myProvider.postSms(v, context, widget.smsRegisterPage);
          }
        },
      ),
    );
  }
}
