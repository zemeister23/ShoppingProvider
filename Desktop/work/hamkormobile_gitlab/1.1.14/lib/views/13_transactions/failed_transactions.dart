import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'dart:ui' as ui;
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'dart:ui';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';

class FailedTransactions extends StatelessWidget {
  const FailedTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConst.instance.horizPadding),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: constraints.maxHeight / 14.5,
                  child: Container(
                      width: constraints.maxWidth / 3.8,
                      height: constraints.maxWidth / 4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                          ImageConst.instance.alertEror,
                        )),
                        color: ColorConst.instance.kErrorColor,
                        borderRadius: BorderRadius.circular(
                            constraints.maxHeight * 0.037),
                      )),
                ),
                Center(
                  child: SizedBox(
                    height: constraints.maxHeight / 1.3,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: CurvedPaint(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConst.instance.horizPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: constraints.maxHeight / 9,
                            ),
                            DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 15, // FontSizeConst.instance.small,
                                color: ColorConst.instance.kSecondaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                              child: Text(
                                "Произошла ошибка",
                                style: TextStyle(
                                  color: ColorConst.instance.kMainTextColor,
                                  fontSize: FontSizeConst.instance.extraLarge,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "sender".locale, //     _data["title"][index],
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "sdgdhrr", //  _data["body"][index],
                                  style: TextStyle(
                                    height: context.h * 0.0025,
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: ColorConst.instance.kElementsColor,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "senders_card"
                                      .locale, //     _data["title"][index],
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "asfge", //  _data["body"][index],
                                  style: TextStyle(
                                    height: context.h * 0.0025,
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: ColorConst.instance.kElementsColor,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "recipient"
                                      .locale, //     _data["title"][index],
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "asfedfgeg", //  _data["body"][index],
                                  style: TextStyle(
                                    height: context.h * 0.0025,
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: ColorConst.instance.kElementsColor,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "recipients_card"
                                      .locale, //     _data["title"][index],
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "bbb", //  _data["body"][index],
                                  style: TextStyle(
                                    height: context.h * 0.0025,
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: ColorConst.instance.kElementsColor,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Cумма перевода:", //     _data["title"][index],
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "a123",
                                  style: TextStyle(
                                    height: context.h * 0.0025,
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: ColorConst.instance.kElementsColor,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "commission_amount"
                                      .locale, //     _data["title"][index],
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "a123",
                                  style: TextStyle(
                                    height: context.h * 0.0025,
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: ColorConst.instance.kElementsColor,
                              thickness: 1,
                            ),
                            const Spacer(),
                            _buttonBottom(context, constraints),
                            _buttonTop(context, constraints),
                            SizedBox(height: SizeConst.instance.verticPadding),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  ElevatedButton _buttonBottom(
      BuildContext context, BoxConstraints constraints) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          constraints.maxHeight / 2,
          constraints.maxHeight / 16.04,
        ),
        primary: ColorConst.instance.kErrorColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            constraints.maxHeight / 81.2,
          ),
        ),
      ),
      onPressed: () {},
      child: AutoSizeText(
        "Повторить перевод",
        maxLines: 1,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: ui.FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  OutlinedButton _buttonTop(BuildContext context, BoxConstraints constraints) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(
          constraints.maxHeight / 2,
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
      onPressed: () {},
      child: AutoSizeText(
        "На главную",
        maxLines: 1,
        style: TextStyle(
          color: ColorConst.instance.kErrorColor,
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
