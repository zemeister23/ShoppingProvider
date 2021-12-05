import 'package:get/get.dart';

class SelectAnimals extends GetxController {
  List<String> typeOfAnimals = ["Chorva", "Parranda", "Baliq", "Boshqa"];
  List<String> animalsData = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Cow_%28Fleckvieh_breed%29_Oeschinensee_Slaunger_2009-07-07.jpg/1200px-Cow_%28Fleckvieh_breed%29_Oeschinensee_Slaunger_2009-07-07.jpg",
    "https://lookw.ru/9/970/1566943698-1-22.jpg",
    "https://www.pixelstalk.net/wp-content/uploads/2016/10/Chicken-Wallpapers-HD-Free-Download.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Cow_%28Fleckvieh_breed%29_Oeschinensee_Slaunger_2009-07-07.jpg/1200px-Cow_%28Fleckvieh_breed%29_Oeschinensee_Slaunger_2009-07-07.jpg",
  ];

  RxInt currentAnimal = 0.obs;
  int chooseAnimal(int currentIndex) => currentAnimal.value = currentIndex;
}
