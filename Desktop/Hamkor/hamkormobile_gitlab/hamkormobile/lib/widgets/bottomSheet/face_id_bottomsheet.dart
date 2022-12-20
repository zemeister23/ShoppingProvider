import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/widgets/outlined_buttun.dart';
import 'dart:math';

class FaceIDBottomsheet extends StatelessWidget {
//  final VoidCallback? onTapTop;
//  final VoidCallback? onTapBottom;

//   FaceIDBottomsheet({Key? key, this.onTapTop, this.onTapBottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
 static Future show({required BuildContext context,required VoidCallback onTapTop,required VoidCallback onTapTopBottom}) {
    // Navigator.pop(context);
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      context: context,
      builder: (v) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(clipBehavior: Clip.none, children: [
              Container(
                width: 1.sw,
                height: 755.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      16.r,
                    ),
                    topRight: Radius.circular(
                      26.r,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                               GetStorageService.instance.box.write( GetStorageService.instance.hasFaceTouch, "false");
                            Navigator.pop(context);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.all(24.w),
                                child: Container(
                                  width: 16.6.h,
                                  height: 16.6.h,
                                  child: SvgPicture.asset(
                                    ImageConst.instance.toSvg("bottom-close"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60.h - 24.w,
                        ),
                        Container(
                          width: 229.w,
                          height: 229.w,
                          alignment: Alignment.center,
                          child: Container(
                            width: 189.w,
                            height: 189.w,
                            alignment: Alignment.center,
                            child: Container(
                              width: 149.w,
                              height: 149.w,
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 59.w,
                                width: 59.w,
                                child: Center(
                                  child: SvgPicture.asset(
                                    height: 59.w,
                                    width: 59.w,
                                    ImageConst.instance.toSvg("face-id"),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  74.5.w,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment(0, 0.08),
                                  end: Alignment(0, 0.93),
                                  colors: [
                                    Color(0xff7FC080),
                                    Color(0xffACDE86),
                                  ],
                                  transform: GradientRotation(pi / 6),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0, 0.08),
                                end: Alignment(0, 0.93),
                                colors: [
                                  Color(0xff7FC080).withOpacity(0.4),
                                  Color(0xffACDE86).withOpacity(0.4),
                                ],
                                transform: GradientRotation(pi / 6),
                              ),
                              borderRadius: BorderRadius.circular(
                                94.5.w,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0, 0.08),
                              end: Alignment(0, 0.93),
                              colors: [
                                Color(0xff7FC080).withOpacity(0.15),
                                Color(0xffACDE86).withOpacity(0.15),
                              ],
                              transform: GradientRotation(pi / 6),
                            ),
                            borderRadius: BorderRadius.circular(
                              114.5.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 77.w,
                        ),
                        Text(
                          "biometric_activate_title".locale,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: 28.w,
                          ),
                          child: Text(
                              "biometric_activate_subtitle".locale,
                            style: TextStyle(
                              color: Color(0xff778892),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                       
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GradientButton(
                            width: 343.w,
                            height: 56.h,
                            text: "activate".locale,
                            colorOpacity: true,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            color: ColorConst.instance.kPrimaryColor,
                            onPressed: onTapTop),
                        SizedBox(
                          height: 20.h,
                        ),
                       OutlinedButtonW(
                          opacity: 1,
                          text: "not_activate".locale,
                          width: 339.w,
                          height: SizeConst.instance.buttonSize,
                          onPressed: onTapTopBottom
                        ),
                    SizedBox(
                          height: 54.h,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]);
          },
        );
      },
    );
  }

}