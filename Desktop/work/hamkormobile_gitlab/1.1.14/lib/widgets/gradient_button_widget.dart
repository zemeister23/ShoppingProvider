import 'package:flutter/material.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double? height;
  final double? width;
  final bool colorOpacity;
  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.height = 56,
    this.width = 200,
    required this.colorOpacity,
  }) : super(key: key);

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
                    ColorConst.instance.kPrimaryColor.withOpacity(0.7),
                    ColorConst.instance.kPrimaryColor,
                    ColorConst.instance.kPrimaryColor,
                  ]
                : <Color>[
                    ColorConst.instance.kPrimaryColor.withOpacity(0.4),
                    ColorConst.instance.kPrimaryColor.withOpacity(0.7),
                    ColorConst.instance.kPrimaryColor.withOpacity(0.7),
                  ],
          ),
        ),
        child: RawMaterialButton(
          elevation: 0,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.h * 0.006),
          ),
          splashColor: ColorConst.instance.kPrimaryColor.withOpacity(0.75),
          child: Text(
            text,
            style: context.theme.button,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
