import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/login/sign_in.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
              textLogin(),
              numbers(context),
              signUpButton(context),
            ],
          ),
        ),
      ),
    ));
  }

  Padding textLogin() {
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

  Padding signUpButton(context) {
    return Padding(
        padding: EdgeInsets.only(top: Get.width * 0.09),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Ro'yhatdan O'tish"),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                fixedSize: Size(Get.width * 0.4, Get.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
            ),
          ],
        ));
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
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                label: Text("Foydalanuvchi nomi"),
                hintText: "Ism Sharif",
              ),
              validator: (name) {
                if (name!.isEmpty) return "Ism To'ldirilishi Shart !";
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                label: Text("Email manzil"),
                hintText: "misol@gmail.com",
              ),
              validator: (email) {
                if (email!.isEmpty) {
                  return "Email Bo'sh Bo'lmasligi Kera !";
                } else if (!email.isEmail) {
                  return "Emailni To'g'ri Kiritishingiz Shart !";
                }
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                label: Text("Parol"),
                hintText: "**********",
              ),
              obscureText: true,
              validator: (password) {
                if (password!.isEmpty) {
                  return "Parol Bo'sh Bo'lmasligi Kera !";
                } else if (password.length <= 5) {
                  return "Parolni 6 ta Iboradan Kam Bo'lmasligi Kerak !";
                }
              },
            ),
            Stack(
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
                  textFieldController: _phoneController,
                  formatInput: false,
                  maxLength: 9,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  cursorColor: Colors.black,
                  inputDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
                    border: InputBorder.none,
                    hintText: 'Telefon Raqam',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                  onSaved: (PhoneNumber number) async {
                    await signUpToBackend(number, context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            "Muvaffaqiyatli Ro'yhatdan O'tdingiz ! Tizimga Kirishingiz Mumkin !"),
                      ),
                    );
                    Get.offAll(SignIn());
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
          ],
        ),
      ),
    );
  }

  Future signUpToBackend(number, context) async {
    await Dio().post(ipAdress + '/users', data: {
      "username": _usernameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "phone": number.toString(),
      "slug": number.toString().split('+')[1],
    });
  }
}
