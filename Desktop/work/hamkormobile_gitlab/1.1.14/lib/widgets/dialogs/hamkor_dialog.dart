import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

import '../../routes/router/router.dart';

class HamkorDialog extends StatelessWidget {
  final String title,  buttonTextRight;
  final Text subtitle;
  final String? buttonTextLeft;
  final VoidCallback? onPressedRight, onPressedLeft;

  const HamkorDialog({
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
          painter: HamkorDialogCustomPainter(),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.38,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
               const   Spacer(flex: 2,),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: FontSizeConst.instance.medium,
                          fontWeight: ui.FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),       
                  Expanded(
                    flex: 3,
                    child:  Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: context.w * 0.065),
                          child:subtitle,
                        ),
                      ), 
                  ),
                 SizedBox(height: context.h * 0.01),
                  buttonTextLeft != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _leftButton(context),
                            _rightButton(context),
                          ],
                        )
                      : _rightButton(context),
                  SizedBox(height: context.h * 0.02),
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
      width: context.w * 0.4,
      height: context.h * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressedRight ??
            () {
               NavigationService.instance
                          .pushNamed(routeName: '/5_pincode');
                  
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
          primary: Theme.of(context).colorScheme.primary,
          side:const BorderSide(
            color: Colors.red,//Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressedLeft ??
            () {
              Navigator.pop(context);
            },
        child: Text(
          buttonTextLeft ?? "",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: ui.FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HamkorDialogCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = ColorConst.instance.kPrimaryColor.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.3566667, 0, size.width * 0.2766667,
                size.height * 0.2686084),
            bottomRight: Radius.circular(size.width * 0.1000000),
            bottomLeft: Radius.circular(size.width * 0.1000000),
            topLeft: Radius.circular(size.width * 0.1000000),
            topRight: Radius.circular(size.width * 0.1000000)),
        paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.4733367, size.height * 0.09710000);
    path_1.lineTo(size.width * 0.5082433, size.height * 0.09710000);
    path_1.lineTo(size.width * 0.4682067, size.height * 0.1985880);
    path_1.lineTo(size.width * 0.4333333, size.height * 0.1985880);
    path_1.lineTo(size.width * 0.4733367, size.height * 0.09710000);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5229767, size.height * 0.07119741);
    path_2.lineTo(size.width * 0.5578467, size.height * 0.07119741);
    path_2.lineTo(size.width * 0.5178433, size.height * 0.1726854);
    path_2.lineTo(size.width * 0.4829700, size.height * 0.1726854);
    path_2.lineTo(size.width * 0.5229767, size.height * 0.07119741);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3333333, size.height * 0.1391586);
    path_3.cubicTo(
        size.width * 0.3333333,
        size.height * 0.1105612,
        size.width * 0.3094553,
        size.height * 0.08737864,
        size.width * 0.2800000,
        size.height * 0.08737864);
    path_3.lineTo(size.width * 0.05333333, size.height * 0.08737864);
    path_3.cubicTo(size.width * 0.02387813, size.height * 0.08737864, 0,
        size.height * 0.1105612, 0, size.height * 0.1391586);
    path_3.lineTo(0, size.height * 0.9482201);
    path_3.cubicTo(0, size.height * 0.9768188, size.width * 0.02387817,
        size.height, size.width * 0.05333333, size.height);
    path_3.lineTo(size.width * 0.9466667, size.height);
    path_3.cubicTo(size.width * 0.9761233, size.height, size.width,
        size.height * 0.9768188, size.width, size.height * 0.9482201);
    path_3.lineTo(size.width, size.height * 0.1391586);
    path_3.cubicTo(
        size.width,
        size.height * 0.1105612,
        size.width * 0.9761233,
        size.height * 0.08737864,
        size.width * 0.9466667,
        size.height * 0.08737864);
    path_3.lineTo(size.width * 0.7100000, size.height * 0.08737864);
    path_3.cubicTo(
        size.width * 0.6805433,
        size.height * 0.08737864,
        size.width * 0.6566667,
        size.height * 0.1105612,
        size.width * 0.6566667,
        size.height * 0.1391586);
    path_3.lineTo(size.width * 0.6566667, size.height * 0.1765333);
    path_3.cubicTo(
        size.width * 0.6566667,
        size.height * 0.2390900,
        size.width * 0.6044333,
        size.height * 0.2898023,
        size.width * 0.5400000,
        size.height * 0.2898023);
    path_3.lineTo(size.width * 0.4500000, size.height * 0.2898023);
    path_3.cubicTo(
        size.width * 0.3855667,
        size.height * 0.2898023,
        size.width * 0.3333333,
        size.height * 0.2390900,
        size.width * 0.3333333,
        size.height * 0.1765337);
    path_3.lineTo(size.width * 0.3333333, size.height * 0.1391586);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
