import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/provider/1_intro_provider.dart';
import 'package:mobile/provider/2_registration_provider.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/14_language_service.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/network/dio/endpoints.dart';
import '../../provider/check_pass_code_provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List imageList = [
    ImageConst.instance.uzbFlag,
    ImageConst.instance.rusFlag,
  ];

  final List name = ["O’zbekcha", "Русский"];

  final List miniName = ["Uzb", "Pyc"];

  late CheckPassCodeProvider passProvider;

  @override
  void initState() {
    super.initState();
    Provider.of<CheckPassCodeProvider>(context, listen: false)
        .changeIsPopToTrue;

    context.introPr.getLanguage();
  }

  late HomeProvider _homeProvider;
  @override
  void didChangeDependencies() {
    _homeProvider = Provider.of(context, listen: false);
    passProvider = Provider.of<CheckPassCodeProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    passProvider.isPop = false;
    _homeProvider.changeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF117E7A),
                Color(0xFF24CC8B),
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: ColorConst.instance.kButtonColor.withOpacity(0.8),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  "profile".locale,
                  style: TextStyle(
                    color: ColorConst.instance.kButtonColor.withOpacity(0.8),
                    fontSize: FontSizeConst.instance.medium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Container(
                width: context.h * 0.1,
                height: context.h * 0.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorConst.instance.kProfileColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConst.instance.kButtonColor.withOpacity(0.4),
                    width: 3,
                  ),
                ),
                child: Text(
                  GetStorageService.instance.box
                              .read(GetStorageService.instance.name) !=
                          null
                      ? GetStorageService.instance.box
                              .read(GetStorageService.instance.name)
                              .toString()
                              .split(" ")[0][0] +
                          GetStorageService.instance.box
                              .read(GetStorageService.instance.name)
                              .toString()
                              .split(" ")[1][0]
                      : "EX",
                  style: TextStyle(
                    color: ColorConst.instance.kButtonColor.withOpacity(0.6),
                    fontSize: FontSizeConst.instance.mainPageUZSSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                GetStorageService.instance.box
                        .read(GetStorageService.instance.name) ??
                    "first_and_last_name".locale,
                style: TextStyle(
                  color: ColorConst.instance.kButtonColor.withOpacity(0.86),
                  fontSize: FontSizeConst.instance.extraLarge,
                  fontWeight: FontWeight.w600,
                  height: context.h * 0.0025,
                ),
              ),
              const Spacer(flex: 1),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConst.instance.paddingW,
                ),
                leading: SvgPicture.asset(
                  ImageConst.instance.toSvg("internet"),
                ),
                title: Text(
                  "change_language".locale,
                  style: FontstyleText.instance.profilePageListTile,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: ColorConst.instance.kButtonColor.withOpacity(0.8),
                ),
                onTap: () async {
                  await bottomSheet(context);
                },
              ),

              // ListTile(
              //   contentPadding: EdgeInsets.symmetric(
              //     horizontal: SizeConst.instance.paddingW,
              //   ),
              //   leading: SvgPicture.asset(
              //     ImageConst.instance.toSvg("location_white"),
              //   ),
              //   title: Text(
              //     "atms_and_branches".locale,
              //     style: FontstyleText.instance.profilePageListTile,
              //   ),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right_rounded,
              //     color: ColorConst.instance.kButtonColor.withOpacity(0.8),
              //   ),
              //   onTap: () {
              //     NavigationService.instance.pushNamed(
              //       routeName: NavigationConst.MAP_PAGE_VIEW,
              //     );
              //   },
              // ),

              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConst.instance.paddingW,
                ),
                leading: SvgPicture.asset(
                  ImageConst.instance.toSvg("head_phones"),
                ),
                title: Text(
                  "feedback".locale,
                  style: FontstyleText.instance.profilePageListTile,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: ColorConst.instance.kButtonColor.withOpacity(0.8),
                ),
                onTap: () async {
                  final Uri telLaunchUri = Uri(
                    scheme: 'tel',
                    path: '1256',
                  );
                  await launchUrl(telLaunchUri);
                  // await launchUrlString("tel:1256");
                  //    obratnayaSvazModalSheet();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConst.instance.paddingW,
                ),
                leading: SvgPicture.asset(
                  ImageConst.instance.toSvg("doc"),
                ),
                title: Text(
                  "oferta".locale,
                  style: FontstyleText.instance.profilePageListTile,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: ColorConst.instance.kButtonColor.withOpacity(0.8),
                ),
                onTap: () {
                  NavigationService.instance.pushNamed(
                      routeName: NavigationConst.VIEW_OFERTA_PAGE_VIEW);
                },
              ),
              const Spacer(flex: 10),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConst.instance.paddingW,
                ),
                leading: SvgPicture.asset(
                  ImageConst.instance.toSvg("log_out"),
                ),
                title: Text(
                  "exit".locale,
                  style: FontstyleText.instance.profilePageListTile,
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: ColorConst.instance.kButtonColor.withOpacity(0.8),
                ),
                onTap: () async {
                  await context.introPr.exitApp();
                },
              ),
              SizedBox(height: 25.h),
              Text(
                "version".locale +
                    GetStorageService.instance.box
                        .read(GetStorageService.instance.version)
                        .toString(),
                //  +Endpoints.status,
                style: TextStyle(
                  fontSize: 16.sp, //FontSizeConst.instance.medium,
                  color: ColorConst.instance.kButtonColor.withOpacity(0.86),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 15.h), // ! VERSIONN
            ],
          ),
        ),
      ),
    );
  }

  obratnayaSvazModalSheet() {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorConst.instance.kButtonColor,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: context.w * 0.04),
                fixedSize: Size(
                  context.w * 0.95,
                  context.h * 0.07,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.h * 0.02),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    color: ColorConst.instance.kMainTextColor,
                  ),
                  SizedBox(width: context.w * 0.05),
                  Text(
                    "Вызов 1256",
                    style: TextStyle(
                      color: ColorConst.instance.kBlueColor,
                      fontSize: FontSizeConst.instance.medium,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: "1256",
                );
                await launchUrlString("tel: 1256");
              },
            ),
            SizedBox(height: context.h * 0.01),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: ColorConst.instance.kButtonColor,
                alignment: Alignment.center,
                fixedSize: Size(
                  context.w * 0.95,
                  context.h * 0.07,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.h * 0.02),
                ),
              ),
              child: Text(
                "Отменить",
                style: TextStyle(
                  color: ColorConst.instance.kBlueColor,
                  fontSize: FontSizeConst.instance.medium,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: context.h * 0.01),
          ],
        );
      },
    );
  }

  bottomSheet(
    BuildContext context,
  ) {
    late LanguageModel languageData =
        Provider.of<IntroProvider>(context, listen: false).langugage;
    return showModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(context.h * 0.01),
          topLeft: Radius.circular(context.h * 0.01),
        ),
      ),
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return SafeArea(
            bottom: true,
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: context.h * 0.01),
                  height: context.h * 0.005,
                  width: context.w * 0.07,
                  decoration: BoxDecoration(
                    color: ColorConst.instance.kElementsColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: context.w * 0.05, vertical: context.w * 0.05),
                  alignment: Alignment.centerLeft,
                  child: Text("change_lang".locale,
                      style: context.theme.headline5),
                ),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.w * 0.01),
                      child: const Divider(),
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: languageData.data!.length,
                  padding: EdgeInsets.symmetric(
                      horizontal: 0, vertical: context.h * 0.01),
                  itemBuilder: (BuildContext context, int index) {
                    return Theme(
                      data: ThemeData(
                        unselectedWidgetColor:
                            ColorConst.instance.kSecondaryTextColor,
                      ),
                      child: RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: context.h * 0.022,
                              width: context.h * 0.024,
                              child: SvgPicture.asset(
                                imageList[index],
                                //  color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: context.w * 0.01,
                            ),
                            Text(
                              languageData.data![index].name.toString(),
                            ),
                          ],
                        ),
                        groupValue: context.watch<RegistrationProvider>().value,
                        activeColor: ColorConst.instance.kPrimaryColor,
                        onChanged: (int? value) async {
                          Provider.of<RegistrationProvider>(context,
                                  listen: false)
                              .changeRadioButton(value!, context);
                          PutLanguageApi.instance.putLanguage();
                          Navigator.pop(context);
                        },
                        value: index,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
