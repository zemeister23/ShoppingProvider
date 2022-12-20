import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/client_name_model.dart';
import 'package:mobile/models/p2p_template_model.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/shimmers.dart';

class HomeAppBarWidget extends StatelessWidget {
  final Future<ClientNameModel> clientNameData;
  final Future<ClientCardsModel> clientcardsData;
  final Future<P2PTemplatesModel> p2pTemplatesData;
  final HomeProvider homeProvider;

  const HomeAppBarWidget(
      {super.key,
      required this.clientNameData,
      required this.clientcardsData,
      required this.p2pTemplatesData,
      required this.homeProvider});
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 67.h),
        clientNameContent(),
        SizedBox(
          height: SizeConst.instance.minSize,
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConst.instance.horizPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FutureBuilder<ClientCardsModel>(
                    future: clientcardsData,
                    builder: (context, snap) {
                      if (snap.hasData) {
                        ClientCardsModel data = snap.data!;
                        return totalBalance(context, data);
                      } else if (snap.hasError) {
                        return SizedBox();
                      } else {
                        return hiveDataBalances();
                      }
                    },
                  ),
                  Text(
                    "UZS  ",
                    style: FontstyleText.instance.mainPageUZS,
                  ),
                ],
              ),
              Text(
                "total_balance".locale,
                style: TextStyle(
                  color: ColorConst.instance.kButtonColor.withOpacity(0.74),
                  fontSize: FontSizeConst.instance.bottom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        p2pTemplatesContent()
      ],
    );
  }

  clientNameContent() {
    return FutureBuilder<ClientNameModel>(
      future: clientNameData,
      builder: (context, snap) {
        if (snap.hasData) {
          if (snap.data!.data != null) {
            GetStorageService.instance.box.write(
              GetStorageService.instance.name,
              snap.data!.data!.firstName! + " " + snap.data!.data!.lastName!,
            );
            ClientNameModel data = snap.data!;
            return clientNameWidget(data);
          } else {
            return Shimmers.instance.circleAvatar;
          }
        } else if (snap.hasError) {
          //
          return SizedBox();
        } else {
          return hiveClentNameData();
        }
      },
    );
  }

  hiveClentNameData() {
    try {
      return FutureBuilder(
          future: HiveService.instance.readBox(
              encKey: Endpoints.clientName, boxName: HiveBoxName.CLIENT_NAME),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return clientNameWidget(snapshot.data);
            } else {
              return Shimmers.instance.circleAvatar;
            }
          });
    } catch (e) {
      return Shimmers.instance.circleAvatar;
    }
  }

  clientNameWidget(ClientNameModel data) {
    return Padding(
      padding: EdgeInsets.only(left: SizeConst.instance.horizPadding),
      child: InkWell(
        onTap: () =>
            NavigationService.instance.pushNamed(routeName: "/16_profile"),
        child: Container(
          width: 30.w,
          height: 30.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorConst.instance.kProfileColor.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorConst.instance.kButtonColor.withOpacity(0.4),
              width: 1.5.r,
            ),
          ),
          child: Text(
            data.data!.firstName![0].toString() +
                data.data!.lastName![0].toString(),
            style: TextStyle(
              color: ColorConst.instance.kButtonColor.withOpacity(0.8),
              fontSize: FontSizeConst.instance.extraSmall,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Text totalBalance(BuildContext context, ClientCardsModel clientCardsModel) {
    return Text(
      context.homePr.responseCardsBalances == null
          ? context.homePr
              .changeAllText(clientCardsModel.data!.totalSum.toString())
          : context.homePr.changeAllText(
              context.homePr.responseCardsBalances!.data!.totalSum.toString()),
      style: FontstyleText.instance.mainPageCheck,
    );
  }

  hiveDataBalances() {
    return FutureBuilder(
        future: HiveService.instance.readBox(
            encKey: Endpoints.clientCards, boxName: HiveBoxName.CLIENT_CARDS),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return totalBalance(context, data);
          } else {
            return Shimmers.instance.ballance;
          }
        });
  }

  hiveDataTemplatesData() {
    return FutureBuilder(
        future: HiveService.instance.readBox(
            encKey: Endpoints.p2pTemplates, boxName: HiveBoxName.P2PTEMPLATES),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return p2pTemplatesAllData(data);
          } else {
            return Shimmers.instance.shablon;
          }
        });
  }

  p2pTemplatesContent() {
    return FutureBuilder<P2PTemplatesModel>(
      future: p2pTemplatesData,
      builder: (context, snap) {
        if (snap.hasData) {
          P2PTemplatesModel data = snap.data!;
          if (data.data!.isEmpty || snap.data == null) {
            homeProvider.changeHasAppBar(false);
            return SizedBox();
          } else {
            homeProvider.changeHasAppBar(true);
            return p2pTemplatesAllData(data);
          }
        } else if (snap.hasError) {
          homeProvider.changeHasAppBar(false);
          return SizedBox();
        } else {
          homeProvider.changeHasAppBar(true);
          return hiveDataTemplatesData();
        }
      },
    );
  }

  p2pTemplatesAllData(P2PTemplatesModel data) {
    if (data.data!.isEmpty) {
      return SizedBox();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: SizeConst.instance.minSize,
        ),
        SizedBox(
          height: 92.h,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: data.data!.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConst.instance.horizPadding,
            ),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 5.w);
            },
            itemBuilder: (BuildContext context, int index) {
              //  context.homePr.reciverPan(snap.data!.data![index].receiverPan.toString());
              return ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: InkWell(
                    onTap: () {
                      context.transactionsPr.homeData = data;
                      context.transactionsPr.homeDataIndex = index;
                      context.transactionsPr.changeTransferHomePageData(true);
                      NavigationService.instance.pushNamed(
                        routeName: NavigationConst.TRANLATIONS_PAGE_VIEW,
                      );
                    },
                    child: Container(
                      width: 92.w,
                      padding: EdgeInsets.all(7.w),
                      decoration: BoxDecoration(
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          width: 1.45.r,
                          color:
                              ColorConst.instance.kButtonColor.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                          AutoSizeText(
                            "${data.data![index].receiver!.owner.toString()}",
                            maxLines: 1,
                            style: TextStyle(
                              color: ColorConst.instance.kButtonColor
                                  .withOpacity(0.7),
                              fontSize: FontSizeConst.instance.small,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(""
                              "${context.homePr.smallCardNumber(data.data![index].receiver!.pan.toString())}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
