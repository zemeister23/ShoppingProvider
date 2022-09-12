import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/branches_model.dart';
import 'package:mobile/views/map/fillials_screen.dart';
import 'package:mobile/models/bancomates_model.dart' as bancomate;

class HumoScreen extends StatelessWidget {
  const HumoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }

  static Future humo(BuildContext context,List<bancomate.Datum> data,int i) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (v) {
       
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              // alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -55.w,
                  left: context.w * 0.5 - 45.w,
                  child: SvgPicture.asset(
                    ImageConst.instance.toSvg("humo_rectangle"),
                    width: 90.w,
                    height: 90.w,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomPaint(
                    painter: RPSCustomPainter(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        context.w * 0.03,
                        context.h * 0.1,
                        context.w * 0.03,
                        context.h * 0.03,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "bancomates".locale + ": "+
                                  data[i].type.toString().split("Type.")[1],
                              style: TextStyle(
                                color: ColorConst.instance.kMainTextColor,
                                fontSize: FontSizeConst.instance.extraLarge,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: context.h * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                             "address".locale,
                                style: context.theme.caption,
                              ),
                              SizedBox(height: context.h * 0.0075),
                              Text(
                                context.mapPr.textBancomates(data, i),
                                style: TextStyle(
                                  color: ColorConst.instance.kMainTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.circle,
                                    color: ColorConst.instance.kPrimaryColor,
                                    size: context.h * 0.015,
                                  ),
                                  Text(
                                     "target".locale,
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    context.mapPr.orienterBancomates(data, i),
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: context.h * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "work_schedule".locale,
                                style: context.theme.caption,
                              ),
                              SizedBox(height: context.h * 0.0075),
                              Row(
                                children: <Widget>[
                                  Text(
                                    context.mapPr.timeBancomes(data, i),
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    " " +
                                        context.mapPr.workDaysBancomes(data, i),
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: context.h * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "services2".locale,
                                style: context.theme.caption,
                              ),
                              SizedBox(height: context.h * 0.0075),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.w * 0.03),
                                child: Text(
                                  context.mapPr.serviceBancomates(data, i),
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  
  
 
  }
}

