import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  double? height;
  double? width;
  final bool colorOpacity;
  TextStyle? style;
  Color? color = ColorConst.instance.kPrimaryColor;
  GradientButton({
    Key? key,
    this.color,
    required this.onPressed,
    required this.text,
    height,
    width,
   
    required this.colorOpacity,
     this.style,
  }) : super(key: key) {
    this.height = height ?? 56.h;
    this.width = width ?? 200.w;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.h * 0.01),
      ),
      elevation: 0,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.h * 0.01),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: colorOpacity
                ? <Color>[
                    (color ?? ColorConst.instance.kPrimaryColor)
                        .withOpacity(0.7),
                    (color ?? ColorConst.instance.kPrimaryColor),
                    (color ?? ColorConst.instance.kPrimaryColor),
                  ]
                : <Color>[
                    (color ?? ColorConst.instance.kPrimaryColor)
                        .withOpacity(0.4),
                    (color ?? ColorConst.instance.kPrimaryColor)
                        .withOpacity(0.7),
                    (color ?? ColorConst.instance.kPrimaryColor)
                        .withOpacity(0.7),
                  ],
          ),
        ),
        child: RawMaterialButton(
          elevation: 0,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          splashColor: ColorConst.instance.kPrimaryColor.withOpacity(0.75),
          child: Text(
            text,
            style:style ?? context.theme.button,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
