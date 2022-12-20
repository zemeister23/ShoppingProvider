import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/p2p_confirm_model.dart';
import 'package:mobile/models/p2p_sucses_validate.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import "package:mobile/core/extensions/context_extension.dart";
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

import '../../provider/check_pass_code_provider.dart';

class SucsesTransactionsScreen extends StatefulWidget {
  SucsesTransactionsScreen({Key? key}) : super(key: key);

  @override
  State<SucsesTransactionsScreen> createState() =>
      _SucsesTransactionsScreenState();
}

class _SucsesTransactionsScreenState extends State<SucsesTransactionsScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    context.transactionsPr.initState();
    Provider.of<CheckPassCodeProvider>(context, listen: false)
        .changeIsPopToTrue;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    P2PConfirmModel data = context.transactionsPr.responseP2pConffirm;
    return BaseView(
        viewModal: SucsesTransactionsScreen,
        onPageBuilder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.w * 0.04),
                child: Column(
                  children: <Widget>[
                    Screenshot(
                      controller: screenshotController,
                      child: Container(
                        width: double.infinity,
                        height: context.h * 0.75,
                        padding: EdgeInsets.all(context.w * 0.04),
                        decoration: BoxDecoration(
                          color: ColorConst.instance.kInputColor,
                          borderRadius:
                              BorderRadius.circular(context.h * 0.013),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 12,
                              color: ColorConst.instance.kMainTextColor
                                  .withOpacity(0.08),
                              offset: const Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SvgPicture.asset(
                              ImageConst.instance.toSvg("logo"),
                              width: context.w * 0.4,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      Provider.of<HomeProvider>(context)
                                          .changeAllText(
                                        data.data!.sum.toString(),
                                      ),
                                      style: context.theme.headline4,
                                    ),
                                    Text(
                                      "UZS",
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.medium,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "success_transfer".locale,
                                  style: TextStyle(
                                    color: const Color(0xFF5FB14B),
                                    fontSize: FontSizeConst.instance.small,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "type_of_transaction"
                                          .locale, //     _data["title"][index],
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      data.data!.productName
                                          .toString(), //  _data["body"][index],
                                      style: TextStyle(
                                        height: context.h * 0.0025,
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: ColorConst.instance.kElementsColor,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "sender"
                                          .locale, //     _data["title"][index],
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      data.data!.senderName
                                          .toString(), //  _data["body"][index],
                                      style: TextStyle(
                                        height: context.h * 0.0025,
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: ColorConst.instance.kElementsColor,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "senders_card"
                                          .locale, //     _data["title"][index],
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      data.data!.senderPan
                                          .toString(), //  _data["body"][index],
                                      style: TextStyle(
                                        height: context.h * 0.0025,
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: ColorConst.instance.kElementsColor,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "recipient"
                                          .locale, //     _data["title"][index],
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      data.data!.receiverName
                                          .toString(), //  _data["body"][index],
                                      style: TextStyle(
                                        height: context.h * 0.0025,
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: ColorConst.instance.kElementsColor,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "recipients_card"
                                          .locale, //     _data["title"][index],
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      data.data!.receiverPan
                                          .toString(), //  _data["body"][index],
                                      style: TextStyle(
                                        height: context.h * 0.0025,
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: ColorConst.instance.kElementsColor,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "commission_amount"
                                          .locale, //     _data["title"][index],
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      data.data!.commissionSum
                                          .toString(), //  _data["body"][index],
                                      style: TextStyle(
                                        height: context.h * 0.0025,
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: ColorConst.instance.kElementsColor,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "transaction_ID"
                                          .locale, //     _data["title"][index],
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      height: context.h * 0.03,
                                      width: context.w * 0.5,
                                      child: AutoSizeText(
                                        data.data!.transactId.toString(),
                                        maxFontSize: 14,
                                        minFontSize: 7,
                                        style: TextStyle(
                                          height: context.h * 0.0025,
                                          color: ColorConst
                                              .instance.kMainTextColor,
                                          fontSize:
                                              FontSizeConst.instance.small,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: ColorConst.instance.kElementsColor,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "date"
                                          .locale, //     _data["title"][index],
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      data.data!.operationTime
                                          .toString(), //  _data["body"][index],
                                      style: TextStyle(
                                        height: context.h * 0.0025,
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: ColorConst.instance.kElementsColor,
                                  thickness: 1,
                                ),
                              ],
                            ),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(ImageConst.instance
                                      .toSvg("take_picture")),
                                  Text(
                                    "take_p2p_screenshot".locale,
                                    style: context.theme.caption,
                                  ),
                                ],
                              ),
                              onTap: () {
                                shareScreenShot(screenshotController);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    /*    Visibility(
                visible: isError,
                child: ElevatedButtonW(
                  width: double.infinity,
                  height: context.h * 0.075,
                  text: "Повторить попытку",
                  onPressed: () {},
                ),
              ),*/
                    GradientButton(
                      width: double.infinity,
                      height: context.h * 0.075,
                      text: "to_home_page".locale,
                      colorOpacity: true,
                      onPressed: () {
                        NavigationService.instance
                            .pushNamedRemoveUntil(routeName: "/home");
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  shareScreenShot(ScreenshotController screenshotcontroller) async {
    await screenshotcontroller
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
      }
    });
  }
}
