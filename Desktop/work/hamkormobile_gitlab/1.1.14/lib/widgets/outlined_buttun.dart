import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/views/8_razvilka/razvilka_screen.dart';

class OutlinedButtonW extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double? height;
  final double? width;
  final double? opacity;

  const OutlinedButtonW({
    Key? key,
    required this.onPressed,
    required this.text,
    this.height = 56,
    this.width = 200,
    this.opacity = 0.75,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton(
      width: width!,
      height: height!,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.h * 0.016),
        ),
      ),
      gradient: LinearGradient(colors: [
        ColorConst.instance.kPrimaryColor.withOpacity(0.45),
        ColorConst.instance.kPrimaryColor,
        ColorConst.instance.kPrimaryColor
      ]),
      onPressed: onPressed!,
      child: GradientText(
        text,
        gradient: LinearGradient(colors: [
          ColorConst.instance.kPrimaryColor.withOpacity(0.65),
          ColorConst.instance.kPrimaryColor,
          ColorConst.instance.kPrimaryColor
        ]),
        style: TextStyle(
          color: ColorConst.instance.kPrimaryColor.withOpacity(opacity!),
          fontSize: FontSizeConst.instance.medium,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class MyOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Gradient? gradient;
  final double thickness;
  final double width;
  final double height;

  const MyOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.width,
    required this.height,
    this.style,
    this.gradient,
    this.thickness = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(context.h * 0.01), //0.16
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConst.instance.kBackgroundColor,
          borderRadius: BorderRadius.circular(context.h * 0.008), //0.16
        ),
        width: width,
        height: height - 6.h,
        margin: EdgeInsets.all(thickness),
        child: OutlinedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        ),
      ),
    );
  }
}
