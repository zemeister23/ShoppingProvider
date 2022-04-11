import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyPasswordController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();

  void checkFields() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
    notifyListeners();
  }
}
