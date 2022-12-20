import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
import 'package:mobile/core/components/input_decoration/form_input_decoration.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/provider/2_registration_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RegistrationInputField extends StatelessWidget {
  RegistrationInputField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RegistrationProvider myProvider = context.watch<RegistrationProvider>();
    return Form(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
          BoxShadow(
            color:ColorConst.instance.inputShadow,
            blurRadius: 13.r,
            offset: const Offset(0,0),
          ),
        ],
        ),
        child: TextFormField( 
          autofocus: true,
          onChanged: (v) {
            context.phoneRegisterPr.changeTest(v, context);
                     },
          controller: context.phoneRegisterPr.phoneNumberController,
          keyboardType: TextInputType.number,
          //  autofocus: true,
          //focusNode: focusNode,
          cursorColor: ColorConst.instance.kPrimaryColor,
          inputFormatters: [MaskInputFormatter(mask: '## ### ## ##')],
          style: context.theme.headline6,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(   
            focusedBorder: DecoInput.instance.focusedBorder(
              myProvider.isRed
                  ? ColorConst.instance.kErrorColor
                  : Colors.transparent,
            ),    
            enabledBorder: DecoInput.instance.focusedBorder(
              myProvider.isRed
                  ? ColorConst.instance.kErrorColor
                  : Colors.transparent,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 47.h),
            disabledBorder:
                OutlineInputBorder( borderRadius: BorderRadius.circular(50)),
            focusColor: ColorConst.instance.kInputColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            isCollapsed: true,
            fillColor: ColorConst.instance.kInputColor,
            border: DecoInput.instance.outlineBorder(10.r),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10.h,),
                Text("+998 ", style: context.theme.headline6),
                Container(
                  height: 35.h,
                  width: 1,
                  color: ColorConst.instance.kHungrylackColor,
                ),
                SizedBox(
                  width: 10.w,
                ),
                 SizedBox(
                  width: context.w * 0.014,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
