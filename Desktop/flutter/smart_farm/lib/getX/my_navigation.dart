import 'package:get/get.dart';

class MyNavigationOnTap extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt newsCurrentIndex = 0.obs;

  int onTapIndex(int index) => currentIndex.value = index;
  int onPageChengedNews(int index) => newsCurrentIndex.value = index;
}
