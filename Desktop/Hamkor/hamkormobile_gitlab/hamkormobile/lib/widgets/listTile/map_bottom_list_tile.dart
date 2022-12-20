import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class MapListTileW extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leading;
  final String open;
  final VoidCallback onTap;
  final String? distance;
  bool isOpen = true;
  MapListTileW({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.onTap,
    required this.open,
    this.distance,
    isOpen,
  }) : super(key: key) {
    this.isOpen = isOpen ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.only(right: context.w * 0.03),
      horizontalTitleGap: 0,
      leading: SvgPicture.asset(
        ImageConst.instance.toSvg(leading),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 180.w,
            child: AutoSizeText(
              title,
              style: context.theme.caption,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AutoSizeText(
            distance ?? "0m",
            style: TextStyle(
                color: ColorConst.instance.kSecondaryTextColor,
                fontSize: FontSizeConst.instance.bottom,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
      subtitle: 
      Padding(
        padding: EdgeInsets.only(right: context.w * 0.1),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              subtitle,
              style: FontstyleText.instance.mainPageMultiWithUzcard,
            ),
            Text(
              open,
              style: TextStyle(
                color: isOpen
                    ? ColorConst.instance.kPrimaryColor
                    : ColorConst.instance.kErrorColor,
                fontSize: FontSizeConst.instance.bottom,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
     
      ),
    
    );
  }
}
