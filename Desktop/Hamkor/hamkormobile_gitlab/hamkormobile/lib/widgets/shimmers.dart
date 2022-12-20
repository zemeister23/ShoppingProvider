import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/10_home/_widgets/_divider_widget.dart';
import 'package:mobile/views/10_home/_widgets/_expansion_tile.dart';
import 'package:mobile/views/10_home/_widgets/_list_tile.dart';
import 'package:mobile/views/10_home/_widgets/shimmer_comp.dart';

import 'package:shimmer/shimmer.dart';

class Shimmers {
  static final Shimmers _instance = Shimmers._init();
  static Shimmers get instance => _instance;
  Shimmers._init();

   
  
  final Padding circleAvatar = Padding(
    padding: EdgeInsets.only(left: SizeConst.instance.horizPadding),
    child: Shimmer(
      gradient: ShimmerComp.instance.appBarGradient,
      child: InkWell(
        onTap: () {
          
          NavigationService.instance.pushNamed(routeName: "/16_profile");
        },
        child: Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        ),
      ),
    ),
  );

  final Shimmer ballance = Shimmer(
    gradient: ShimmerComp.instance.appBarGradient,
    child: Card(
      child: SizedBox(
        width: 150.w,
        height: 47.h,
      ),
    ),
  );

  final SizedBox shablon = SizedBox(
    height: 92.w,
    child: Shimmer(
      gradient: ShimmerComp.instance.appBarGradient,
      child: ListView.separated(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConst.instance.horizPadding,
        ),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 5.w);
        },
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                width: 92.w,
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  color: ColorConst.instance.kButtonColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    width: 1.45.r,
                    color: ColorConst.instance.kButtonColor.withOpacity(0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset(
                          ImageConst.instance.toSvg("exchange"),
                        ),
                        SvgPicture.asset(
                          ImageConst.instance.toSvg("cancel"),
                          color: ColorConst.instance.kButtonColor,
                        ),
                      ],
                    ),
                    Spacer(),
                    Card(
                      child: SizedBox(
                        width: context.w * 0.13,
                        height: context.h * 0.015,
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: double.infinity,
                        height: context.h * 0.015,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );

  ExpansionTileW cardsAndAccounts(BuildContext context) {
    return ExpansionTileW(
      title: "cards_accounts".locale,
      height: context.h * 0.2,
      padding: context.w * 0.03,
      dataLength: 3,
      isCardsAndAccounts: true,
      isExpanded: context.homePrStreem.isExpanded,
      onTab: () {
        context.homePr.changeIsExpanded();
      },
      child: ListView.separated(
        itemCount: 3,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return const DividerW();
        },
        itemBuilder: (BuildContext context, int index) {
          return Shimmer(
            gradient: ShimmerComp.instance.bodyGradient,
            child: ListTileW(
              leading: Container(
                width: context.w * 0.13,
                height: context.h * 0.05,
                decoration: BoxDecoration(
                  color: ColorConst.instance.kErrorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              title: Card(
                child: SizedBox(
                  width: context.w * 0.4,
                  height: context.h * 0.015,
                ),
              ),
              isTrailingCurrency: false,
              subTitle: Card(
                child: SizedBox(
                  width: context.w * 0.3,
                  height: context.h * 0.015,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding deposits(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConst.instance.verticPadding),
      child: ExpansionTileW(
        title: "",  
        height: context.h * 0.2,
        padding: context.w * 0.03,
        dataLength: 2,
        isCardsAndAccounts: true,
        isExpanded: context.homePrStreem.isExpandedDeposits,
        onTab: () {},
        child: ListView.separated(
          itemCount: 2,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const DividerW();
          },
          itemBuilder: (BuildContext context, int index) {
            return Shimmer(
              gradient: ShimmerComp.instance.bodyGradient,
              child: ListTileW(
                leading: Container(
                  width: context.w * 0.13,
                  height: context.h * 0.05,
                  decoration: BoxDecoration(
                    color: ColorConst.instance.kErrorColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                title: Card(
                  child: SizedBox(
                    width: context.w * 0.4,
                    height: context.h * 0.015,
                  ),
                ),
                isTrailingCurrency: false,
                subTitle: Card(
                  child: SizedBox(
                    width: context.w * 0.3,
                    height: context.h * 0.015,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ExpansionTileW credits(BuildContext context) {
    return ExpansionTileW(
      title: "",  
      height: context.h * 0.2,
      padding: context.w * 0.03,
      dataLength: 2,
      isCardsAndAccounts: true,
      isExpanded: context.homePrStreem.isExpandedkridit,
      onTab: () {},
      child: ListView.separated(
        itemCount: 2,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return const DividerW();
        },
        itemBuilder: (BuildContext context, int index) {
          return Shimmer(
            gradient: ShimmerComp.instance.bodyGradient,
            child: ListTileW(
              leading: Container(
                width: context.w * 0.13,
                height: context.h * 0.05,
                decoration: BoxDecoration(
                  color: ColorConst.instance.kErrorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              title: Card(
                child: SizedBox(
                  width: context.w * 0.4,
                  height: context.h * 0.015,
                ),
              ),
              isTrailingCurrency: false,
              subTitle: Card(
                child: SizedBox(
                  width: context.w * 0.3,
                  height: context.h * 0.015,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding exchangeRates(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: context.h * 0.01,
          left: context.w * 0.03,
          right: context.w * 0.03),
      child: Container(
          decoration: BoxDecoration(
              color: ColorConst.instance.kInputColor,
              borderRadius: BorderRadius.circular(context.h * 0.01)),
          height: (context.h * 0.042) * 2,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer(
                gradient: ShimmerComp.instance.bodyGradient,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      child: SizedBox(
                        width: context.w * 0.12,
                        height: context.h * 0.02,
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: context.w * 0.12,
                        height: context.h * 0.02,
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: context.w * 0.12,
                        height: context.h * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
              Shimmer(
                gradient: ShimmerComp.instance.bodyGradient,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      child: SizedBox(
                        width: context.w * 0.12,
                        height: context.h * 0.02,
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: context.w * 0.12,
                        height: context.h * 0.02,
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: context.w * 0.12,
                        height: context.h * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
