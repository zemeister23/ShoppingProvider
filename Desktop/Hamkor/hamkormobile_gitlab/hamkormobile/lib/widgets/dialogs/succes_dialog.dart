import 'dart:ui' as ui;
import 'dart:ui';
import 'package:mobile/core/extensions/context_extension.dart';

import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';

class SuccesDialog extends StatelessWidget {
  final String title, subtitle, buttonText;
  final VoidCallback? onPressed;

  const SuccesDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.onPressed,
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
          painter: SuccesDialogCustomPainter(),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.42,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.h * 0.03),
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
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: FontSizeConst.instance.small,
                        color: ColorConst.instance.kSecondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(height: context.h * 0.02),
                  SizedBox(
                    width: context.w * 0.4,
                    height: context.h * 0.075,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConst.instance.kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: onPressed ??
                          () {
                            Navigator.pop(context);
                          },
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: ui.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.h * 0.005),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SuccesDialogCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff5FB14B).withOpacity(1.0);
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
    path_1.moveTo(size.width * 0.4419800, size.height * 0.1738973);
    path_1.lineTo(size.width * 0.4784367, size.height * 0.2167890);
    path_1.lineTo(size.width * 0.5513533, size.height * 0.1248776);

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01000000;
    paint_1_stroke.color = Colors.white.withOpacity(1.0);
    paint_1_stroke.strokeCap = StrokeCap.round;
    paint_1_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Colors.transparent;
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
