import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class CurrencyFormat extends TextInputFormatter{
 TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final money = NumberFormat(
      "###,###,###",
      "en_US",
    );
    String newText = money.format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
}  

}