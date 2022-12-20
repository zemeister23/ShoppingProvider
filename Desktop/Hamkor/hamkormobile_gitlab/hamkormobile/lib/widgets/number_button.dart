import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/service/api_service/face_id_touch_id_service/face_id_touch_id_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/5_pin-code_auth_provider.dart';
import 'package:mobile/provider/6_check_pin_code_provider.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class NumButton extends StatefulWidget {
  final bool pageState;
  final bool isLockScreen;
  final bool isPop;
  final bool isCheckPassCode;
  final VoidCallback? onCompleted;
  NumButton({
    Key? key,
    this.pageState = true,
    this.isLockScreen = false,
    this.isPop = false,
    this.isCheckPassCode = false,
    this.onCompleted 
  }) : super(key: key);

  @override
  State<NumButton> createState() => _NumButtonState();
}

class _NumButtonState extends State<NumButton> {

  @override
  void initState() {
   
    widget.isLockScreen ? context.passCodePr.storegePassCodeLength() : null;
    
   
    super.initState();
  }
  Widget build(BuildContext context) {

    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              numButton(1, context),
              numButton(2, context),
              numButton(3, context),
            ],
          ),
        )),
        Expanded(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              numButton(4, context),
              numButton(5, context),
              numButton(6, context),
            ],
          ),
        )),
        Expanded(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              numButton(7, context),
              numButton(8, context),
              numButton(9, context),
            ],
          ),
        )),
        Expanded(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           faceSpacer(context),
              numButton(0, context),
              deleteButton(11, context),
            ],
          ),
        )),
      ],
    );
  }

  bool state = true;
 


  Widget faceSpacer(BuildContext context) {
    return SizedBox(
      height: context.h * 0.095,
      width: context.w * 0.2,
    );
  }

  ElevatedButton numButton(
    int number,
    BuildContext context,
  ) {
    var myProvider2 =
        Provider.of<CheckPassCodeProvider>(context, listen: false);

    return ElevatedButton(
      onPressed: () async {
          widget.pageState
            ? widget.isLockScreen
                ? await myProvider2.onCompleted(number, context, widget.isPop,onPressed: widget.onCompleted)
                : await Provider.of<PinCodeAuthProvider>(context, listen: false)
                    .onCompleted(number)
            : await Provider.of<CheckPinCodeProvider>(context, listen: false)
                .onCompleted(number, context);
      
      },
      child: Text(number.toString(), style: context.theme.headline2),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.h * 0.01)),
        primary: ColorConst.instance.kInputColor,
        onPrimary: ColorConst.instance.kPrimaryColor,
        fixedSize: Size(
            SizeConst.instance.numButttonW, SizeConst.instance.numButttonH),
        shadowColor: Colors.transparent,
      ),
    );
  }

  bool passCodeParseList(CheckPassCodeProvider myProvider2) {
    if (myProvider2.pinCodeCount.toString() ==
        myProvider2.storegePasCode.length.toString()) {
      return true;
    } else {
      return false;
    }
  }
  

  deleteButton(int numbe, BuildContext context) {
    return InkWell(
      onTap: () {
        widget.pageState
            ? widget.isLockScreen
                ? Provider.of<CheckPassCodeProvider>(context, listen: false)
                    .deleteItem(1)
                : Provider.of<PinCodeAuthProvider>(context, listen: false)
                    .deleteItem(1)
            : Provider.of<CheckPinCodeProvider>(context, listen: false)
                .deleteItem(1);
      },
      child: SizedBox(
          height: context.h * 0.095,
          width: context.w * 0.2,
          child: Center(
            child: SvgPicture.asset(
              ImageConst.instance.imageBack,
              color: ColorConst.instance.kMainTextColor,
            ),
          )),
    );
  }

  Widget freeSpace(BuildContext context) {
    return SizedBox(
      width: context.w * 0.2,
      height: context.h * 0.095,
    );
  }

 

}
