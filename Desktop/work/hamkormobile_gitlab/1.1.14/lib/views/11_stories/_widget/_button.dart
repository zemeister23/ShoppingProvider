import 'package:flutter/material.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class StoriesGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double? height;
  final double? width;
  const StoriesGradientButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.height = 56,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.h * 0.015),
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.h * 0.015),
          color: const Color(0xFF8E69FA),
        ),
        child: RawMaterialButton(
          elevation: 0,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.h * 0.015),
          ),
          splashColor: ColorConst.instance.kPrimaryColor.withOpacity(0.75),
          child: Text(text, style: context.theme.button),
        ),
      ),
    );
  }
}
