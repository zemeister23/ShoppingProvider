import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class ListTileForStoryW extends StatelessWidget {
  final String psCode;
  final String title;
  final String subTitle;
  final String trailing;
  final bool isIncome;
  final String codeCurrency;

  const ListTileForStoryW({
    Key? key,
    required this.psCode,
    required this.title,
    required this.subTitle,
    required this.trailing,
    required this.isIncome,
    required this.codeCurrency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.h * 0.1,
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.h * 0.01,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: context.w * 0.13,
            height: context.h * 0.05,
            padding: EdgeInsets.all(context.h * 0.01),
            decoration: BoxDecoration(
              color: ColorConst.instance.kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              ImageConst.instance.toSvg("hamkor_dialog"),
            ),
          ),
          SizedBox(width: context.w * 0.03),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: context.w * 0.4,
                child: Text(
                  title,
                   style: context.theme.caption, 
                   overflow: TextOverflow.ellipsis,
                   ),
              ),
            
               Row(
                children: [
                     SvgPicture.asset(
                  psCode == "UZCARD" ?   ImageConst.instance.toSvg("uzcard") :  ImageConst.instance.toSvg("humo"),
                  ),
                   Text(
                     subTitle,
                      style:FontstyleText.instance.mainPageMultiWithUzcard,
                    ),
                ],
              
               ),
             
            ],
          ),
        Expanded(
          child: Container(
            width: 70,
            child: AutoSizeText(
                 isIncome ? "+" + trailing  +
                 (codeCurrency.trim() == "UZS" ||
                                              codeCurrency.trim() == "860" ||
                                              codeCurrency.trim() == "0"
                                          ? " UZS"
                                          : " USD")
                                            :
                                        
                                          "-" + trailing +  (codeCurrency.trim() == "UZS" ||
                                              codeCurrency.trim() == "860" ||
                                              codeCurrency.trim() == "0"
                                          ? " UZS"
                                          : " USD"),
                maxLines: 1,
             //  maxFontSize: FontSizeConst.instance.medium,
              //R  minFontSize: FontSizeConst.instance.small,
                 textAlign: TextAlign.end,
                 style: isIncome
                      ? TextStyle(
                        color: ColorConst.instance.kPrimaryColor,
                        fontSize: FontSizeConst.instance.medium,
                        fontWeight: FontWeight.w400
                      )
                      : context.theme.caption,
                ),
          ),
        ),
         
         
        ],
      ),
    );
  }
}
