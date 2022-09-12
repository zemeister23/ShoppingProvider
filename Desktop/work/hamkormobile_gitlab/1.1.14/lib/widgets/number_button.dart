import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/5_pin-code_auth_provider.dart';
import 'package:mobile/provider/6_check_pin_code_provider.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/3_registration_api.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class NumButton extends StatefulWidget {
  final bool pageState;
  final bool isLockScreen;
  final bool isPop;
  NumButton({
    Key? key,
    this.pageState = true,
    this.isLockScreen = false,
    this.isPop = false,
  }) : super(key: key);

  @override
  State<NumButton> createState() => _NumButtonState();
}

class _NumButtonState extends State<NumButton> {
  @override
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
              freeSpace(context),
              numButton(0, context),
              deleteButton(11, context),
            ],
          ),
        )),
      ],
    );
  }

  bool state = true;

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
                ? await myProvider2.onCompleted(number, context, widget.isPop)
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

  /* if(myProvider2.seconds == 00 && myProvider2.pinCode.isNotEmpty){
      if (listEquals( myProvider2.pinCode,GetStorageService.instance.box.read("passcode"),)) {
                        await GetStorageService.instance.box.write(GetStorageService.instance.isLocked, false);
                       NavigationService.instance.pushNamedRemoveUntil(routeName: "/home");
                      } else {
                         myProvider2.capacity ==-1 ? myProvider2.capacity = 3 :  myProvider2.capacity ;
                          myProvider2.capacity -=1;
                          if(myProvider2.capacity == 0){
                             myProvider2.chageErorColorPinCode(true);
                        myProvider2.starttTimer();
                    
                       myProvider2.capacity -=1;
                       print(myProvider2.seconds.toString() + "SECUNDS");
                      return   dialog(true,context,myProvider2);
                         }
                         else{
                          myProvider.chageErorColorPinCode(true);
                          dialog(false,context,myProvider2);
                        }    
                      } 
                      }
*/

  Widget freeSpace(BuildContext context) {
    return SizedBox(
      width: context.w * 0.2,
      height: context.h * 0.095,
    );
  }

  Widget deleteButton(int numbe, BuildContext context) {
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

  dialogEror(
      bool viewSeconds, BuildContext context, CheckPassCodeProvider provider) {
    return showDialog(
        context: context,
        builder: (context) {
          state = true;
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              child: Text(viewSeconds
                  ? "Pin code xato terildi ${context.watch<CheckPassCodeProvider>().seconds} soniyadan keyin qayta urinib korin"
                  : "Pin code xato terildi ${context.watch<CheckPassCodeProvider>().capacity} urinish qoldi "),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "cancel_passcode_alert".locale,
                    style: TextStyle(color: Colors.black26),
                  )),
              TextButton(
                  onPressed: () async {
                    await GetStorageService.instance.box.write(
                        GetStorageService.instance.isAuthenticated, false);
                    await GetStorageService.instance.box.write(
                        GetStorageService.instance.isLockScreenShowed, false);
                    context.smsPr.stopTimer();
                    await context.introPr.exitApp();
                    NavigationService.instance
                        .pushNamedRemoveUntil(routeName: "/1_intro")
                        .then((value) => provider.startTimer(context));
                  },
                  child: Text("registration".locale))
            ],
          );
        });
  }
}
/*  pageState
            ? isLockScreen
                ? await myProvider2
                    .onCompleted(number)
                : await Provider.of<PinCodeAuthProvider>(context, listen: false)
                    .onCompleted(number)
            : await Provider.of<CheckPinCodeProvider>(context, listen: false)
                .onCompleted(number, context);
        if(isLockScreen && passCodeParseList(myProvider2) && myProvider2.seconds == 00 && myProvider2.capacity >0 ){

        if (await listEquals( myProvider2.pinCode,GetStorageService.instance.box.read("passcode"),)) {
                        await GetStorageService.instance.box.write(GetStorageService.instance.isLocked, false);
                       NavigationService.instance.pushNamedRemoveUntil(routeName: "/home");
                       state  = false;
                      } 
                      else {
                         myProvider2.capacity ==-1 ? myProvider2.capacity = 3 :  myProvider2.capacity ;
                          myProvider2.capacity -=1;
                          if(myProvider2.capacity == 0){
                       await      myProvider2.chageErorColorPinCode(true);
                        myProvider2.starttTimer();
                    
                       myProvider2.capacity -=1;
                      state = false;
                         }

                     


                         else{
                          print("ELSE ICHIDA ");
                          print(myProvider2.pinCodeCount.toString());
                          print(storegePasCode.length);
                          if(await myProvider2.pinCodeCount.toString() == storegePasCode.length.toString()){
                            print("IF ICHIGA KIRDI");
                       await     myProvider.chageErorColorPinCode(true);
                       await   dialogEror(false,context,myProvider2);


                          }  
                          
                      
                        }    
                      } 





        }
 if(isLockScreen && myProvider2.seconds != 00){
  print("ELSE DIALOgi sihladi");
          return dialog( context);
        }

 */
