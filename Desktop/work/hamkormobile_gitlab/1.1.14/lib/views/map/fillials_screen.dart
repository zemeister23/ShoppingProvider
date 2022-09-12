import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/branches_model.dart' as branche;

class Fillials extends StatelessWidget {
  const Fillials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
  static Future filials(BuildContext context, List<branche.Datum> data,int i) {
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
                  top: -45.w,
                  left: context.w * 0.5 - 45.w,
                  child: SvgPicture.asset(
                    ImageConst.instance.toSvg("hamkor_rectangle"),
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
                        children: <Widget>[
                          Text(
                            data[i].title.toString(),
                            style: TextStyle(
                              color: ColorConst.instance.kMainTextColor,
                              fontSize: FontSizeConst.instance.extraLarge,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                          SizedBox(height: context.h * 0.02.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "address".locale,
                                  style: context.theme.caption,
                                ),
                              ),
                              SizedBox(height: context.h * 0.0075),
                              Text(
                                context.mapPr.textBranches(data, i),
                                style: TextStyle(
                                  color: ColorConst.instance.kMainTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
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
                                    "opening_hours".locale,
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    context.mapPr.timeBranches(data, i),
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                               Text(
                                    "technical_break".locale.replaceAll("NUMBER",  data[i]
                                        .lunchTime
                                        
                                        .toString()
                                        .split("THE_")[1],),
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                               Text(
                                    "sat_sun".locale.replaceAll("NUMBER",  context.mapPr.weekendsBranches(data, i)),
                                    style: TextStyle(
                                      color: ColorConst.instance.kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
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
                                  context.mapPr.serviceBranches(data, i),
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



//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.3706667,size.height*0.03307888);
    path_0.cubicTo(size.width*0.3706667,size.height*0.01480992,size.width*0.3551467,0,size.width*0.3360000,0);
    path_0.lineTo(size.width*0.04266667,0);
    path_0.cubicTo(size.width*0.01910251,0,0,size.height*0.01822761,0,size.height*0.04071247);
    path_0.lineTo(0,size.height*0.9592875);
    path_0.cubicTo(0,size.height*0.9817735,size.width*0.01910253,size.height,size.width*0.04266667,size.height);
    path_0.lineTo(size.width*0.9573333,size.height);
    path_0.cubicTo(size.width*0.9808987,size.height,size.width,size.height*0.9817735,size.width,size.height*0.9592875);
    path_0.lineTo(size.width,size.height*0.04071247);
    path_0.cubicTo(size.width,size.height*0.01822758,size.width*0.9808987,0,size.width*0.9573333,0);
    path_0.lineTo(size.width*0.6640000,0);
    path_0.cubicTo(size.width*0.6448533,0,size.width*0.6293333,size.height*0.01480992,size.width*0.6293333,size.height*0.03307888);
    path_0.cubicTo(size.width*0.6293333,size.height*0.08226463,size.width*0.5875467,size.height*0.1221374,size.width*0.5360000,size.height*0.1221374);
    path_0.lineTo(size.width*0.4640000,size.height*0.1221374);
    path_0.cubicTo(size.width*0.4124533,size.height*0.1221374,size.width*0.3706667,size.height*0.08226463,size.width*0.3706667,size.height*0.03307888);
    path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Colors.white.withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}