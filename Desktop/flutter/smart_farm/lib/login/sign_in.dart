import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_farm/constants.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:smart_farm/home/home_page.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String? _verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _textKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: FadeInDown(
          duration: const Duration(milliseconds: 400),
          child: Column(
            children: [
              testLogin(),
              numbers(context),
              loginButton(context),
            ],
          ),
        ),
      ),
    ));
  }

  Padding testLogin() {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.05),
      child: Text(
        "Tizimga Kirish",
        style: TextStyle(
          fontSize: Get.width * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding loginButton(context) {
    return Padding(
        padding: EdgeInsets.only(top: Get.width * 0.09),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Sms Jo'natish"),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                fixedSize: Size(Get.width * 0.4, Get.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
              onPressed: () async {
                if (_textKey.currentState!.validate()) {
                  await modalBottomSheetForCode(context);
                  _textKey.currentState!.save();
                }
              },
            ),
            TextButton(
              onPressed: () async {
                if (_textKey.currentState!.validate()) {
                  await modalBottomSheetForCode(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text("Telefon raqamga sms jo'natilmagan !"),
                    ),
                  );
                }
              },
              child: const Text("Smsni Kiritish",
                  style: TextStyle(color: kPrimaryColor)),
            ),
          ],
        ));
  }

  modalBottomSheetForCode(context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            constraints: BoxConstraints(maxHeight: Get.height * 0.3),
            onClosing: () {},
            builder: (context) {
              return Column(
                children: [
                  SizedBox(height: Get.height * 0.02),
                  const Text(
                    "Sms kodni shu yerda kiriting",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.3),
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      maxLength: 6,
                      controller: _codeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await signInWithPhoneNumber(context);
                      },
                      child: const Text("Kirish"),
                      style: ElevatedButton.styleFrom(primary: kPrimaryColor)),
                ],
              );
            },
          );
        });
  }

  Container numbers(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.13)),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffeeeeee),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Form(
            key: _textKey,
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {},
              onInputValidated: (bool value) {},
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              textFieldController: controller,
              formatInput: false,
              maxLength: 9,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              cursorColor: Colors.black,
              inputDecoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
                border: InputBorder.none,
                hintText: 'Telefon Raqam',
                hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              ),
              onSaved: (PhoneNumber number) async {
                await verifyPhoneNumber(number.phoneNumber, context);
              },
            ),
          ),
          Positioned(
            left: 90,
            top: 8,
            bottom: 8,
            child: Container(
              height: 40,
              width: 1,
              color: Colors.black.withOpacity(0.13),
            ),
          )
        ],
      ),
    );
  }

  // FUNC FOR VERIFY NUMBER
  Future verifyPhoneNumber(number, context) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "$number",
          timeout: const Duration(seconds: 5),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException authException) {
            debugPrint(
                'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
          },
          codeAutoRetrievalTimeout: (String s) {},
          codeSent: (String verificationId, int? forceResendingToken) {
            _verificationId = verificationId;
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to Verify Phone Number: ${e}")));
    }
  }

  // FUNC FOR SIGN IN AND NAVIGATE TO HOME PAGE
  Future<void> signInWithPhoneNumber(context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _codeController.text,
      );

      final User? user = (await auth.signInWithCredential(credential)).user;

      Get.to(HomePage());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Parolni Tekshirib Qaytadan Tering !")));
    }
  }
}
