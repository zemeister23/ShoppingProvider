import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class ListTileW extends StatelessWidget {
  final Widget subTitle, leading, title;
  final Widget? trailing;
  final String? subTrailing;
  final VoidCallback? onTap;
  final bool isTrailingCurrency;
  final bool? isArrowDownIcon;
  final String codeCurrency;

  const ListTileW({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.leading,
    this.codeCurrency = " UZS",
    required this.isTrailingCurrency,
    this.trailing,
    this.isArrowDownIcon = false,
    this.subTrailing = "",
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: context.h * 0.1,
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.h * 0.01,
        ),
        child: Row(
          children: <Widget>[
            leading,
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      title,
                      SizedBox(width: context.w * 0.03),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            trailing ?? Text(""),
                            isTrailingCurrency
                                ? AutoSizeText(
                                    codeCurrency.trim() == "UZS" ||
                                            codeCurrency.trim() == "860" ||
                                            codeCurrency.trim() == "0"
                                        ? " UZS"
                                        : " USD",
                                    maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: FontSizeConst.instance.small,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      subTitle,
                      AutoSizeText(
                        subTrailing!,
                        style: FontstyleText.instance.subsText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isArrowDownIcon!
                ? Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ColorConst.instance.kElementsColor,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
