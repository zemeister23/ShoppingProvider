import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

import '../container_decoration.dart';

class SmallButton extends StatelessWidget {
  final String title, svgName;
  final VoidCallback? onTap;

  const SmallButton({
    Key? key,
    required this.title,
    required this.svgName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: context.w * 0.45,
        height: double.infinity,
        decoration: ContainerDecorationComp.containerShadow(context),
        child: Padding(
          padding: EdgeInsets.only(left: context.w * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SvgPicture.asset(
                ImageConst.instance.toSvg(svgName),
              ),
              SizedBox(
               width: 110.w,
                child: AutoSizeText(
                  title,
                  style: context.theme.caption,
                 overflow: TextOverflow.ellipsis,
                 maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
