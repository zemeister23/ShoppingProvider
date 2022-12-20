import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';

class BlockDialog extends StatelessWidget {
  final String title, subtitle, buttonTextBottom;
  final VoidCallback? onPressedTop, onPressedBottom;
  final double sizeHeightPainer;
  final double positionTopContainer;
  final bool issubtitleWidget;
  final bool isSmsScreen;
  const BlockDialog(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.buttonTextBottom,
      this.issubtitleWidget = false,
      this.onPressedTop,
      this.onPressedBottom,
      this.positionTopContainer = 3.59,
      this.sizeHeightPainer = 2.82,
      this.isSmsScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
    return BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
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
                              SizedBox(
                                height: constraints.maxHeight / 9.5,
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.01,
                              ),
                              Expanded(
                                flex: 10,
                                child: Container(
                                  // color: Colors.red,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.16),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: FontSizeConst.instance.bottom,
                                      fontWeight: ui.FontWeight.w600,
                                      fontStyle: ui.FontStyle.normal,
                                      color: ColorConst
                                          .instance.kSecondaryTextColor,
                                    ),
                                    child: AutoSizeText(
                                      context.smsPrStream.minut == 0
                                          ? isSmsScreen
                                              ? "block_is_finished".locale
                                              : subtitle
                                          : !isSmsScreen
                                              ? subtitle
                                              : "block_15_min"
                                                  .locale
                                                  .replaceAll(
                                                      "MINUT",
                                                      context.smsPrStream.minut
                                                          .toString()),
                                      textAlign: ui.TextAlign.center,
                                      maxFontSize: 15,
                                      minFontSize: 9,
                                      style: TextStyle(
                                          color: ColorConst
                                              .instance.kSecondaryTextColor,
                                          fontWeight: ui.FontWeight.w400,
                                          fontStyle: ui.FontStyle.normal,
                                          fontSize:
                                              FontSizeConst.instance.bottom),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              _buttonBottom(context, constraints),
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
                                borderRadius: BorderRadius.circular(
                                    constraints.maxHeight * 0.037)),
                            fixedSize: ui.Size(
                              constraints.maxWidth / 3.6,
                              constraints.maxWidth / 3.8,
                            )),
                        onPressed: () {
                          
                          Navigator.pop(context);
                        },
                        child:SvgPicture.asset(
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

  ElevatedButton _buttonBottom(
      BuildContext context, BoxConstraints constraints) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          constraints.maxHeight / 4.286,
          constraints.maxHeight / 15,
        ),
        primary: isSmsScreen
            ? context.smsPrStream.minut != 0
                ? Colors.red.shade200
                : ColorConst.instance.kErrorColor
            : ColorConst.instance.kErrorColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            constraints.maxHeight / 81.2,
          ),
        ),
      ),
      onPressed: isSmsScreen
          ? context.smsPr.minut != 0
              ? () {}
              : onPressedBottom
          : () => Navigator.pop(context),
      child: AutoSizeText(
        isSmsScreen ? "repeat_request".locale : "ok".locale,
        maxLines: 1,
        style: TextStyle(
            fontWeight: ui.FontWeight.w700,
            fontStyle: ui.FontStyle.normal,
            fontSize: FontSizeConst.instance.bottom),
        textAlign: TextAlign.center,
      ),
    );
  }
}
