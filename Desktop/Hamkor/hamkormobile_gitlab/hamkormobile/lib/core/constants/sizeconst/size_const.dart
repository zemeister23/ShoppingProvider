import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeConst {
  static final SizeConst _instance = SizeConst._init();
  static SizeConst get instance => _instance;
  SizeConst._init();
final double h = ScreenUtil().screenHeight;
final double w = ScreenUtil().screenWidth;

// Heights
  final double minSize = 10.h;
  final double verticPadding = 16.h;
  final double numButttonH = 80.h;
  final double pinPointH = 12.h;
  final double buttonSize = 52.h;

  

// Widths
  final double minSizeW = 10.w;
  final double horizPadding = 16.w;
  final double numButttonW = 78.w;
  final double pinPointW = 12.w;
  final double paddingW = 20.w;
}
