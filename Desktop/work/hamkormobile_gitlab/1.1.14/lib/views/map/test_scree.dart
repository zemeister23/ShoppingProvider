import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/widgets/listTile/map_bottom_list_tile.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: InkWell(
        child: Text("Map"),
        onTap: () {
          mapModalBottomSheet(context);
        },
      ),
    ));
  }

  Future mapModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            top: false,
            bottom: true,
            child: Container(
              decoration: BoxDecoration(
                color: ColorConst.instance.kButtonColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: context.h * 0.49,
                    left: context.w * 0.03,
                    child: InkWell(
                      onTap: () => context.mapPr.changeButtonState(0),
                      child: Container(
                        width: context.w * 0.24,
                        height: context.h * 0.06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.mapPrStream.indexButton == 0
                              ? ColorConst.instance.kGreenOpacity
                              : ColorConst.instance.kButtonColor,
                          borderRadius:
                              BorderRadius.circular(context.h * 0.025),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 10,
                              color: ColorConst.instance.kShadowColor
                                  .withOpacity(0.11),
                              offset: const Offset(0, -4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          "Филиалы",
                          style: TextStyle(
                            color: context.mapPrStream.indexButton == 0
                                ? ColorConst.instance.kButtonColor
                                : ColorConst.instance.kMainTextColor,
                            fontSize: FontSizeConst.instance.medium,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: context.h * 0.49,
                    left: context.w * 0.29,
                    child: InkWell(
                      onTap: () => context.mapPr.changeButtonState(1),
                      child: Container(
                        width: context.w * 0.28,
                        height: context.h * 0.06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.mapPrStream.indexButton == 1
                              ? ColorConst.instance.kGreenOpacity
                              : ColorConst.instance.kButtonColor,
                          borderRadius:
                              BorderRadius.circular(context.h * 0.025),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 10,
                              color: ColorConst.instance.kShadowColor
                                  .withOpacity(0.11),
                              offset: const Offset(0, -4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          "Банкоматы",
                          style: TextStyle(
                            color: context.mapPrStream.indexButton == 1
                                ? ColorConst.instance.kButtonColor
                                : ColorConst.instance.kMainTextColor,
                            fontSize: FontSizeConst.instance.medium,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: context.h * 0.49,
                    right: context.w * 0.03,
                    child: InkWell(
                      onTap: () => context.mapPr.changeButtonState(4),
                      child: Container(
                        width: context.w * 0.12,
                        height: context.h * 0.06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.mapPrStream.indexButton == 4
                              ? ColorConst.instance.kGreenOpacity
                              : ColorConst.instance.kButtonColor,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 10,
                              color: ColorConst.instance.kShadowColor
                                  .withOpacity(0.11),
                              offset: const Offset(0, -4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          ImageConst.instance.toSvg("gps"),
                          color: context.mapPrStream.indexButton == 4
                              ? ColorConst.instance.kButtonColor
                              : ColorConst.instance.kPrimaryColor,
                          width: context.h * 0.04,
                          height: context.h * 0.04,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: context.h * 0.49,
                    right: context.w * 0.16,
                    child: InkWell(
                      onTap: () => context.mapPr.changeButtonState(3),
                      child: Container(
                        width: context.w * 0.12,
                        height: context.h * 0.06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.mapPrStream.indexButton == 3
                              ? ColorConst.instance.kGreenOpacity
                              : ColorConst.instance.kButtonColor,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 10,
                              color: ColorConst.instance.kShadowColor
                                  .withOpacity(0.11),
                              offset: const Offset(0, -4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          ImageConst.instance.toSvg("humo_map_logo"),
                          color: context.mapPrStream.indexButton == 3
                              ? ColorConst.instance.kButtonColor
                              : ColorConst.instance.kPrimaryColor,
                          width: context.h * 0.04,
                          height: context.h * 0.04,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: context.h * 0.49,
                    right: context.w * 0.29,
                    child: InkWell(
                      onTap: () => context.mapPr.changeButtonState(2),
                      child: Container(
                        width: context.w * 0.12,
                        height: context.h * 0.06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.mapPr.indexButton == 2
                              ? ColorConst.instance.kGreenOpacity
                              : ColorConst.instance.kButtonColor,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 10,
                              color: ColorConst.instance.kShadowColor
                                  .withOpacity(0.11),
                              offset: const Offset(0, -4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          ImageConst.instance.toSvg("uzcard_map_logo"),
                          color: context.mapPr.indexButton == 2
                              ? ColorConst.instance.kButtonColor
                              : ColorConst.instance.kPrimaryColor,
                          width: context.h * 0.04,
                          height: context.h * 0.04,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: context.h * 0.025),
                      Center(
                        child: Image.asset(
                          ImageConst.instance.toPng("divider"),
                        ),
                      ),
                      SizedBox(height: context.h * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.w * 0.04,
                        ),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(context.h * 0.02),
                            child: StatefulBuilder(builder: (context, setSate) {
                              return ExpansionTile(
                                onExpansionChanged: (v) {
                                  context.mapPr.changeisExpanded();
                                },
                                initiallyExpanded: context.mapPrStream
                                    .isExpanded, // context.mapPrStream.isExpanded,
                                collapsedIconColor:
                                    ColorConst.instance.kElementsColor,
                                iconColor: ColorConst.instance.kElementsColor,
                                backgroundColor:
                                    ColorConst.instance.kBackgroundColor,
                                collapsedBackgroundColor:
                                    ColorConst.instance.kBackgroundColor,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                childrenPadding: EdgeInsets.symmetric(
                                  horizontal: context.w * 0.04,
                                ),
                                title: Text(
                                  "город Ташкент",
                                  style: context.theme.bodyText1,
                                ),
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: context.h * 0.2,
                                    child: ListView.builder(
                                      itemCount: 3,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: Text(
                                            "aa",
                                            style: TextStyle(
                                              color: ColorConst
                                                  .instance.kSecondaryTextColor,
                                              fontSize:
                                                  FontSizeConst.instance.small2,
                                              fontWeight: FontWeight.w600,
                                              height: context.h * 0.004,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              );
                            })),
                      ),
                      SizedBox(height: context.h * 0.01),
                      SizedBox(
                        height: context.h * 0.3,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.w * 0.04,
                                    vertical: context.h * 0.02,
                                  ),
                                  child: Text(
                                    "В радиусе 1 км",
                                    style: TextStyle(
                                      color: ColorConst
                                          .instance.kSecondaryTextColor,
                                      fontSize: FontSizeConst.instance.bottom,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                MapListTileW(
                                    open: "",
                                    onTap: () {
                                      context.mapPr.bancomateIndex = index;
                                      context.mapPr.changeBottomSheetIndex(2);
                                    },
                                    leading: "hamkor_rectangle",
                                    title: "Bancomats : ",
                                    subtitle: "asd"),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
