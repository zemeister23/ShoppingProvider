import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class AlertyDialog extends StatelessWidget {
  final String title, subtitle, buttonTextRight;
  final String? buttonTextLeft;
  final VoidCallback? onPressedRight, onPressedLeft;

  const AlertyDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.buttonTextRight,
    this.buttonTextLeft,
    this.onPressedRight,
    this.onPressedLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.transparent,
        child: CustomPaint(
          painter: AlertDialogCustomPainter(),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.40,
            child: Padding(
              padding:  EdgeInsets.all(context.h * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Flexible(child: SizedBox(height: context.h * 0.1)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: FontSizeConst.instance.medium,
                      fontWeight: ui.FontWeight.bold,

                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.h * 0.015),
                  SizedBox(
                    height: context.h * 0.06,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.w * 0.05),
                      child: Container(
                        height: context.h * 0.08,
                        color: ColorConst.instance.kErrorColor,
                        child: AutoSizeText(
                          subtitle,
                          style: TextStyle(
                            fontSize: FontSizeConst.instance.small,
                            color: ColorConst.instance.kSecondaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.h * 0.02),
                  buttonTextLeft != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _leftButton(context),
                            _rightButton(context),
                          ],
                        )
                      : _rightButton(context),
                  SizedBox(height: context.h * 0.005),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _rightButton(BuildContext context) {
    return SizedBox(
      width:145,// context.w * 0.6,
      height: context.h * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorConst.instance.kAlertColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.h * 0.01),
          ),
        ),
        onPressed: onPressedRight ??
            () {
              Navigator.pop(context);
            },
        child: Text(
          buttonTextRight,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: ui.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SizedBox _leftButton(BuildContext context) {
    return SizedBox(
      width: context.w * 0.3,
      height: context.h * 0.05,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: ColorConst.instance.kAlertColor,
          side: BorderSide(
            color: ColorConst.instance.kAlertColor,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.h * 0.01),
          ),
        ),
        onPressed: onPressedLeft ??
            () {
              Navigator.pop(context);
            },
        child: Text(
          buttonTextLeft ?? "",
          style: TextStyle(
            color: ColorConst.instance.kAlertColor,
            fontWeight: ui.FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class AlertDialogCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffFEA666).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.3566667, 0, size.width * 0.2766667,
                size.height * 0.3254902),
            bottomRight: Radius.circular(size.width * 0.1000000),
            bottomLeft: Radius.circular(size.width * 0.1000000),
            topLeft: Radius.circular(size.width * 0.1000000),
            topRight: Radius.circular(size.width * 0.1000000)),
        paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.4863033, size.height * 0.1046553);
    path_1.cubicTo(
        size.width * 0.4861567,
        size.height * 0.1029514,
        size.width * 0.4863167,
        size.height * 0.1012306,
        size.width * 0.4867700,
        size.height * 0.09960353);
    path_1.cubicTo(
        size.width * 0.4872267,
        size.height * 0.09797647,
        size.width * 0.4879667,
        size.height * 0.09648000,
        size.width * 0.4889433,
        size.height * 0.09520980);
    path_1.cubicTo(
        size.width * 0.4899200,
        size.height * 0.09394000,
        size.width * 0.4911100,
        size.height * 0.09292471,
        size.width * 0.4924400,
        size.height * 0.09223020);
    path_1.cubicTo(
        size.width * 0.4937700,
        size.height * 0.09153529,
        size.width * 0.4952100,
        size.height * 0.09117647,
        size.width * 0.4966667,
        size.height * 0.09117647);
    path_1.cubicTo(
        size.width * 0.4981233,
        size.height * 0.09117647,
        size.width * 0.4995633,
        size.height * 0.09153529,
        size.width * 0.5008933,
        size.height * 0.09223020);
    path_1.cubicTo(
        size.width * 0.5022233,
        size.height * 0.09292471,
        size.width * 0.5034133,
        size.height * 0.09394000,
        size.width * 0.5043900,
        size.height * 0.09520980);
    path_1.cubicTo(
        size.width * 0.5053667,
        size.height * 0.09648000,
        size.width * 0.5061067,
        size.height * 0.09797647,
        size.width * 0.5065633,
        size.height * 0.09960353);
    path_1.cubicTo(
        size.width * 0.5070167,
        size.height * 0.1012306,
        size.width * 0.5071767,
        size.height * 0.1029514,
        size.width * 0.5070300,
        size.height * 0.1046553);
    path_1.lineTo(size.width * 0.5029900, size.height * 0.1824741);
    path_1.cubicTo(
        size.width * 0.5028333,
        size.height * 0.1843192,
        size.width * 0.5021000,
        size.height * 0.1860306,
        size.width * 0.5009300,
        size.height * 0.1872749);
    path_1.cubicTo(
        size.width * 0.4997633,
        size.height * 0.1885196,
        size.width * 0.4982433,
        size.height * 0.1892090,
        size.width * 0.4966667,
        size.height * 0.1892090);
    path_1.cubicTo(
        size.width * 0.4950900,
        size.height * 0.1892090,
        size.width * 0.4935700,
        size.height * 0.1885196,
        size.width * 0.4924033,
        size.height * 0.1872749);
    path_1.cubicTo(
        size.width * 0.4912333,
        size.height * 0.1860306,
        size.width * 0.4905000,
        size.height * 0.1843192,
        size.width * 0.4903433,
        size.height * 0.1824741);
    path_1.lineTo(size.width * 0.4863033, size.height * 0.1046553);
    path_1.close();
    path_1.moveTo(size.width * 0.4862500, size.height * 0.2137239);
    path_1.cubicTo(
        size.width * 0.4862500,
        size.height * 0.2104737,
        size.width * 0.4873467,
        size.height * 0.2073569,
        size.width * 0.4893000,
        size.height * 0.2050584);
    path_1.cubicTo(
        size.width * 0.4912533,
        size.height * 0.2027604,
        size.width * 0.4939033,
        size.height * 0.2014690,
        size.width * 0.4966667,
        size.height * 0.2014690);
    path_1.cubicTo(
        size.width * 0.4994300,
        size.height * 0.2014690,
        size.width * 0.5020800,
        size.height * 0.2027604,
        size.width * 0.5040333,
        size.height * 0.2050584);
    path_1.cubicTo(
        size.width * 0.5059867,
        size.height * 0.2073569,
        size.width * 0.5070833,
        size.height * 0.2104737,
        size.width * 0.5070833,
        size.height * 0.2137239);
    path_1.cubicTo(
        size.width * 0.5070833,
        size.height * 0.2169741,
        size.width * 0.5059867,
        size.height * 0.2200914,
        size.width * 0.5040333,
        size.height * 0.2223894);
    path_1.cubicTo(
        size.width * 0.5020800,
        size.height * 0.2246878,
        size.width * 0.4994300,
        size.height * 0.2259788,
        size.width * 0.4966667,
        size.height * 0.2259788);
    path_1.cubicTo(
        size.width * 0.4939033,
        size.height * 0.2259788,
        size.width * 0.4912533,
        size.height * 0.2246878,
        size.width * 0.4893000,
        size.height * 0.2223894);
    path_1.cubicTo(
        size.width * 0.4873467,
        size.height * 0.2200914,
        size.width * 0.4862500,
        size.height * 0.2169741,
        size.width * 0.4862500,
        size.height * 0.2137239);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.3333333, size.height * 0.1843137);
    path_2.cubicTo(
        size.width * 0.3333333,
        size.height * 0.1496604,
        size.width * 0.3094553,
        size.height * 0.1215686,
        size.width * 0.2800000,
        size.height * 0.1215686);
    path_2.lineTo(size.width * 0.05333333, size.height * 0.1215686);
    path_2.cubicTo(size.width * 0.02387813, size.height * 0.1215686, 0,
        size.height * 0.1496604, 0, size.height * 0.1843137);
    path_2.lineTo(0, size.height * 0.9372549);
    path_2.cubicTo(0, size.height * 0.9719098, size.width * 0.02387817,
        size.height, size.width * 0.05333333, size.height);
    path_2.lineTo(size.width * 0.9466667, size.height);
    path_2.cubicTo(size.width * 0.9761233, size.height, size.width,
        size.height * 0.9719098, size.width, size.height * 0.9372549);
    path_2.lineTo(size.width, size.height * 0.1843137);
    path_2.cubicTo(
        size.width,
        size.height * 0.1496604,
        size.width * 0.9761233,
        size.height * 0.1215686,
        size.width * 0.9466667,
        size.height * 0.1215686);
    path_2.lineTo(size.width * 0.7100000, size.height * 0.1215686);
    path_2.cubicTo(
        size.width * 0.6805433,
        size.height * 0.1215686,
        size.width * 0.6566667,
        size.height * 0.1496604,
        size.width * 0.6566667,
        size.height * 0.1843137);
    path_2.lineTo(size.width * 0.6566667, size.height * 0.2156863);
    path_2.cubicTo(
        size.width * 0.6566667,
        size.height * 0.2914902,
        size.width * 0.6044333,
        size.height * 0.3529412,
        size.width * 0.5400000,
        size.height * 0.3529412);
    path_2.lineTo(size.width * 0.4500000, size.height * 0.3529412);
    path_2.cubicTo(
        size.width * 0.3855667,
        size.height * 0.3529412,
        size.width * 0.3333333,
        size.height * 0.2914902,
        size.width * 0.3333333,
        size.height * 0.2156863);
    path_2.lineTo(size.width * 0.3333333, size.height * 0.1843137);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
