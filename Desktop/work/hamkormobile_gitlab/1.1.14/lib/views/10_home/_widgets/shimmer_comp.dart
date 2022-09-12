import 'package:flutter/painting.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';

class ShimmerComp {
  static final ShimmerComp _instance = ShimmerComp._init();
  static ShimmerComp get instance => _instance;
  ShimmerComp._init();

  final LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      ColorConst.instance.kSecondaryTextColor,
      ColorConst.instance.kSecondaryTextColor,
    ],
  );
  final LinearGradient bodyGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      ColorConst.instance.kProfileColor,
      ColorConst.instance.kBacColor,
    ],
  );
}