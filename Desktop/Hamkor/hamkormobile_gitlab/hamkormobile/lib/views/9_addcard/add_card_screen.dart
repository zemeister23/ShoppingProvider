import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/views/9_addcard/_widgets/card_widget.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/widgets/loading/loading_dialog.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);
  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  @override
  void initState() {
    context.addCardPr.dateTime();
    context.addCardPr.cardExpireController.clear();
    context.addCardPr.cardNumberController.clear();
    super.initState();
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.instance.kBackgroundColor,
      appBar: DefaultAppbar.getAppBar(
        "",
        () {
          Navigator.pop(context);
        },
        context,
        true,
      ),
      body: context.addCardPrStreem.loading
          ? LoadingPage(true)
          : SafeArea(
              child: SizedBox(
                width: context.w,
                height: context.h * 0.88,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConst.instance.horizPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30.h),
                      Text(
                        "registration".locale,
                        style: context.theme.headline1,
                      ),
                      SizedBox(height: 20.h),
                      AutoSizeText(
                        "enter_card_number".locale,
                        //  maxFontSize: 17,
                        //   minFontSize: 12,
                        maxLines: 1,
                        style: TextStyle(
                          color: ColorConst.instance.kSecondaryTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CardWidget(),
                      SizedBox(height: context.h * 0.02),
                      AutoSizeText(
                        context.addCardPrStreem.erorMessage.locale,
                        //    maxFontSize: 15,
                        //    minFontSize: 12,
                        maxLines: 1,
                        style: TextStyle(
                          color: ColorConst.instance.kErrorColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      GradientButton(
                        onPressed: !context.addCardPrStreem.erorColorState &&
                                context.addCardPr.cardNumberController.text
                                        .length >=
                                    19 &&
                                context.addCardPr.cardExpireController.text
                                        .length >=
                                    5
                            ? () {
                                // 
                                //     GetStorageService.instance.box.write(GetStorageService.instance.accessToken, "");
                                //     
                                context.loaderOverlay.show();
                                context.addCardPr.postCard(context, false);
                              }
                            : null,
                        text: "continue".locale,
                        colorOpacity: context.addCardPrStreem.buttonOpacity &&
                                !context.addCardPrStreem.erorColorState &&
                                !context.addCardPrStreem.erorColorState &&
                                context.addCardPr.cardNumberController.text
                                        .length >=
                                    19 &&
                                context.addCardPr.cardExpireController.text
                                        .length >=
                                    5
                            ? true
                            : false,
                        width: double.infinity,
                        height: SizeConst.instance.buttonSize,
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
