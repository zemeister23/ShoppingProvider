import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_farm/constants.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

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
              numbers(),
              loginButton(),
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
        "Ro'yhatdan O'tish",
        style: TextStyle(
          fontSize: Get.width * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding loginButton() {
    return Padding(
      padding: EdgeInsets.only(top: Get.width * 0.09),
      child: ElevatedButton(
        child: const Text("Kirish"),
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          fixedSize: Size(Get.width * 0.3, Get.height * 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Container numbers() {
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
          InternationalPhoneNumberInput(
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
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
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
}
