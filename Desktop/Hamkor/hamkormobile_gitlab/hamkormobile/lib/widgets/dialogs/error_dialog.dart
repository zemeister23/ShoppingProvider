import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ErrorDialog extends StatelessWidget {
  final String title, subtitle, buttonTextBottom;
  final String? buttonTextTop;
  final VoidCallback? onPressedTop;
  final VoidCallback? onPressedBottom;
  final double sizeHeightPainer;
  final double positionTopContainer;
  final Widget? subtitleWidget;
  final bool issubtitleWidget;
  final bool titleDone;
  final isDisable;
  const ErrorDialog(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.buttonTextBottom,
      this.buttonTextTop,
      this.subtitleWidget,
      this.issubtitleWidget = false,
      this.onPressedTop,
      this.onPressedBottom,
      this.positionTopContainer = 3.59,
      this.sizeHeightPainer = 2.82,
      this.titleDone = false,
      this.isDisable = false})
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
                      //   color: Colors.red,
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
                              titleDone
                                  ? SizedBox(
                                      height: buttonTextTop != null
                                          ? constraints.maxHeight / 9
                                          : constraints.maxHeight / 9.5,
                                    )
                                  : SizedBox(
                                      height: constraints.maxHeight / 9,
                                    ),
                              DefaultTextStyle(
                                style: TextStyle(
                                  color: ColorConst.instance.kMainTextColor,
                                  fontSize: FontSizeConst.instance.medium,
                                  fontWeight: ui.FontWeight.bold,
                                ),
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                             
                             
                              titleDone
                                  ? SizedBox(
                                      height: constraints.maxHeight * 0.01,
                                    )
                                  : const SizedBox(),
                              Expanded(
                                flex: 10,
                                child: Container(
                                  // color: Colors.red,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: FontSizeConst.instance.bottom,
                                      color: ColorConst
                                          .instance.kSecondaryTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    child: !issubtitleWidget
                                        ? AutoSizeText(
                                            subtitle,
                                            textAlign: ui.TextAlign.center,
                                            maxFontSize: 15,
                                            minFontSize: 9,
                                          )
                                        : subtitleWidget!,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              buttonTextTop != null
                                  ? SizedBox(
                                      //height: constraints.maxHeight / 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _buttonTop(context, constraints),
                                          SizedBox(
                                              height:
                                                  constraints.maxHeight * 0.01),
                                          _buttonBottom(context, constraints),
                                        ],
                                      ),
                                    )
                                  : _buttonBottom(context, constraints),
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
                            primary: ColorConst.instance.kErrorColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r)),
                            fixedSize: ui.Size(
                              constraints.maxWidth / 3.6,
                              constraints.maxWidth / 3.8,
                            )),
                        onPressed: () {
                          
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          ImageConst.instance.alertEror,
                          height: 24.38.h,
                          width: 24.38.w,
                        ),
                        ),
                  ),
                ],
              );
            },
          ),
        ));
  }
  OutlinedButton _buttonTop(BuildContext context, BoxConstraints constraints) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(
          constraints.maxHeight / 3,
          constraints.maxHeight / 16.04,
        ),
        primary: ColorConst.instance.kErrorColor,
        side: BorderSide(
          color: ColorConst.instance.kErrorColor,
          width: 3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
        ),
      ),
      onPressed: onPressedTop ??
          () {
            Navigator.pop(context);
          },
      child: AutoSizeText(
        buttonTextTop ?? "",
        maxLines: 1,
        style: TextStyle(
          color: ColorConst.instance.kErrorColor,
          fontWeight: ui.FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buttonBottom(
      BuildContext context, BoxConstraints constraints) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          buttonTextTop == null
              ? constraints.maxHeight / 4.286
              : constraints.maxHeight / 3,
          constraints.maxHeight / 16.04,
        ),
        primary:
            isDisable ? Colors.red.shade200 : ColorConst.instance.kErrorColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            constraints.maxHeight / 81.2,
          ),
        ),
      ),
      onPressed: onPressedBottom ??
          () {
            
            Navigator.pop(context);
          },
      child: AutoSizeText(
        buttonTextBottom,
        maxLines: 1,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: ui.FontWeight.bold,
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
