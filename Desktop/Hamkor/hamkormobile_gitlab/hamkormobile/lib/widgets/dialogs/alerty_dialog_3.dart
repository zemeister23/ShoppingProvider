import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgp;

class AlertyDialog3 extends StatelessWidget {
  final String title, buttonTextBottom;
  final AutoSizeText subtitle;
  final VoidCallback? onPressedLeft, onPressedRight;
  final String leftText;
  final String rightText;
  final double sizeHeightPainer;
  final double positionTopContainer;
  final bool titleDone;
  const AlertyDialog3(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.buttonTextBottom,
      this.onPressedLeft,
      this.onPressedRight,
      this.positionTopContainer = 3.59,
      this.sizeHeightPainer = 2.82,
      this.titleDone = false,
      required this.leftText,
      required this.rightText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w * 0.098),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    height: constraints.maxHeight / sizeHeightPainer,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: CurvedPaint(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: constraints.maxHeight / 10.5,
                            ),
                            DefaultTextStyle(
                              style: TextStyle(
                                fontSize:
                                    15.sp, // FontSizeConst.instance.small,
                                color: ColorConst.instance.kSecondaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                              child: Text(title),
                            ),
                            //  SizedBox(
                            //     height
                            //         : constraints.maxHeight / 54,
                            //   ),
                            Expanded(
                              flex: 10,
                              child: Container(
                                //  color: Colors.red,
                                margin: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * 0.16),
                                child: DefaultTextStyle(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: FontSizeConst.instance.small,
                                    color:
                                        ColorConst.instance.kSecondaryTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  child: SizedBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: subtitle,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buttonLeft(context, constraints),
                                SizedBox(width: 20.h),
                                _buttonRight(context, constraints),
                              ],
                            ),

                            SizedBox(
                              height: constraints.maxHeight * 0.03,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight / positionTopContainer,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: ColorConst.instance.kAlertColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  constraints.maxHeight * 0.037)),
                          fixedSize: ui.Size(
                            constraints.maxWidth / 3.6,
                            constraints.maxWidth / 3.8,
                          )),
                      onPressed: () {
                        
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(ImageConst.instance.bang,
                          semanticsLabel: 'Acme Logo')),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  OutlinedButton _buttonLeft(BuildContext context, BoxConstraints constraints) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(
          109.w,
          50.h,
        ),
        primary: ColorConst.instance.kAlertColor,
        side: BorderSide(
          color: ColorConst.instance.kAlertColor,
          width: 3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            constraints.maxHeight / 61.2,
          ),
        ),
      ),
      onPressed: onPressedLeft ??
          () {
            Navigator.pop(context);
          },
      child: Text(
        leftText,
        style: TextStyle(
          color: ColorConst.instance.kAlertColor,
          fontWeight: ui.FontWeight.bold,
          fontSize: FontSizeConst.instance.bottom,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buttonRight(
      BuildContext context, BoxConstraints constraints) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        fixedSize: Size(
          109.w,
          50.h,
        ),
        primary: ColorConst.instance.kAlertColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            constraints.maxHeight / 61.2,
          ),
        ),
      ),
      onPressed: onPressedRight ??
          () {
            Navigator.pop(context);
          },
      child: Text(
        rightText,
        maxLines: 1,
        style: TextStyle(
          color: Colors.white,
          fontWeight: ui.FontWeight.bold,
          fontSize: FontSizeConst.instance.bottom,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CurvedPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8;

    Path path = Path();

    path.moveTo(size.width / 3, 20);
    path.lineTo(size.width / 3, 60);
    path.lineTo(size.width / 2, 60);
    path.quadraticBezierTo(size.width / 3, 60, size.width / 3, 20);

    path.moveTo(size.width * 2 / 3, 20);
    path.lineTo(size.width * 2 / 3, 60);
    path.lineTo(size.width / 2, 60);
    path.quadraticBezierTo(size.width * 2 / 3, 60, size.width * 2 / 3, 20);

    path.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTRB(0, 0, size.width / 3, size.height),
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ));

    path.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTRB(size.width * 2 / 3, 0, size.width, size.height),
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
      topLeft: Radius.circular(20),
    ));
    path.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTRB(size.width / 3, 60, size.width * 2 / 3, size.height),
    ));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
