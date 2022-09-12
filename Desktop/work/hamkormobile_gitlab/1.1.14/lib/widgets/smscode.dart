import 'package:flutter/material.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import '../../widgets/3_smscode/send-again.dart';
import '../../widgets/3_smscode/sms_code_form.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
class SmsCode extends StatelessWidget {
 final GlobalKey<FormState> formKey;
  final TextEditingController _controller;
 final String  telNomer;
 final bool registerPage ;
const  SmsCode(this.formKey,this._controller,this.telNomer,this.registerPage,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   //registerPage ?  SmsProvider : ClientRegisterProvider()  myProvider = registerPage ?  context.watch<SmsProvider>() : context.watch<ClientRegisterProvider>();

    return GestureDetector(
          onTap: () {  
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.h * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               const    Spacer(flex: 3,),    
              Text("registration".locale,
              style:context.theme.headline1),  
               const    Spacer(flex: 7,),               
                Text("+998 " +telNomer+" " +"enter_the_code".locale,
              style:context.theme.subtitle2,
              ),      
              const  Spacer(flex: 5,),    
            //    SmsCodeForm(formKey,_controller),     
   //    myProvider.capacity >= 3 ?     Text("resending_code_after".locale + " 0${myProvider.duration.inMinutes}:${(myProvider.duration.inSeconds % 60).toString().padLeft(2, '0')}",      
     //         textAlign: TextAlign.center,
     //         style: context.theme.bodyText2,
     //          ) :const SizedBox(),   
     //       Text(myProvider.invalidSmS(),
     //       style: TextStyle(
     //       color:ColorConst.instance.kErrorColor,
     //      fontSize: FontSizeConst.instance.small2
     //        ),),
            const Spacer(flex: 100,),
            SendAgainTextButton(false,false),
              ],
            ),
          ),
        );
    }
}