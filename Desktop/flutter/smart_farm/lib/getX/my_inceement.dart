import 'package:get/get.dart';

class MyIncrementGetx extends GetxController {
  RxInt incrementValue = 1.obs;

  int addValue() {
    return incrementValue.value += 1;
  }

  int removeValue() {
    if (incrementValue.value > 1) {
      incrementValue.value -= 1;
    }
    return incrementValue.value;
  }
}
