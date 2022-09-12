import 'package:flutter/material.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class DividerW extends StatelessWidget {
  const DividerW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorConst.instance.kElementsColor,
      thickness: 1,
      height: 0,
      indent: context.w * 0.2,
      endIndent: context.w * 0.05,
    );
  }
}
