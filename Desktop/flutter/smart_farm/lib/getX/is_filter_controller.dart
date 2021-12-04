import 'package:get/get.dart';

class IsFilterController extends GetxController {
  RxBool isFiltered = false.obs;

  bool filterControll(bool event) => isFiltered.value = event;
}
