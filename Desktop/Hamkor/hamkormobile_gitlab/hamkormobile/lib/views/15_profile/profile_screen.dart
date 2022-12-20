import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/service/api_service/face_id_touch_id_service/face_id_touch_id_service.dart';
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
import 'package:mobile/widgets/dialogs/alerty_dialog_3.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provider/check_pass_code_provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final List imageList = [
    ImageConst.instance.uzbFlag,
    ImageConst.instance.rusFlag,
  ];
  final List name = ["O’zbekcha", "Русский"];
  final List miniName = ["Uzb", "Pyc"];

  late CheckPassCodeProvider passProvider;
  late LanguageModel languageData =
      Provider.of<IntroProvider>(context, listen: false).langugage;
  AnimationController? animationController;
  late LocalAuthentication auth;
  List<BiometricType> availableBiometrics = [];
  void initState() {
 
   instanseLocalAuth();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    Provider.of<CheckPassCodeProvider>(context, listen: false)
        .changeIsPopToTrue;
    animationController = AnimationController(
      vsync: this,
      upperBound: 17.h,
      value: GetStorageService.instance.box
                  .read(GetStorageService.instance.hasFaceTouch) ==
              "true"
          ? 17.h
          : 0,
      lowerBound: 0,
      duration: Duration(
        milliseconds: 120,
      ),
      animationBehavior: AnimationBehavior.normal,
    )
      ..addListener(() {})
      ..addStatusListener((status) {
        setState(() {});
      })
      ..notifyListeners();
  }
 
 
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // FaceAndTouchIDService.instance.controlCheckBox();
      await instanseLocalAuth();
      setState(() {}); 
    }
    super.didChangeAppLifecycleState(state);
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
        child: AnimatedBuilder(
            animation: animationController!,
            builder: (context, child) {
              return Container(
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
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.8),
                        onPressed: () {
                          NavigationService.instance.pushNamed(
                              routeName: NavigationConst.HOME_PAGE_VIEW);
                          //   Navigator.pop(context);
                        },
                      ),
                      title: Text(
                        "profile".locale,
                        style: TextStyle(
                          color:
                              ColorConst.instance.kButtonColor.withOpacity(0.8),
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
                        color:
                            ColorConst.instance.kProfileColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              ColorConst.instance.kButtonColor.withOpacity(0.4),
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
                          color:
                              ColorConst.instance.kButtonColor.withOpacity(0.6),
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
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.86),
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
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.8),
                      ),
                      onTap: () async {
                        await bottomSheet(context);
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: SizeConst.instance.paddingW,
                      ),
                      leading: SvgPicture.asset(
                        ImageConst.instance.toSvg("location_white"),
                      ),
                      title: Text(
                        "atms_and_branches".locale,
                        style: FontstyleText.instance.profilePageListTile,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.8),
                      ),
                      onTap: () {
                        NavigationService.instance.pushNamed(
                          routeName: NavigationConst.MAP_PAGE_VIEW,
                        );
                      },
                    ),

                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: SizeConst.instance.paddingW,
                      ),
                      leading: SvgPicture.asset(
                        height: 28.w,
                        width: 28.w,
                        ImageConst.instance.toSvg("head_phones"),
                      ),
                      title: Text(
                        "feedback".locale,
                        style: FontstyleText.instance.profilePageListTile,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.8),
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
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.8),
                      ),
                      onTap: () {
                        NavigationService.instance.pushNamed(
                            routeName: NavigationConst.VIEW_OFERTA_PAGE_VIEW);
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: SizeConst.instance.paddingW,
                      ),
                      leading: Container(
                        width: 28.h,
                        height: 28.h,
                        child: SvgPicture.asset(
                          ImageConst.instance.toSvg("face-id"),
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Face/Touch ID",
                        style: FontstyleText.instance.profilePageListTile,
                      ),
                      trailing: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          

                          if (animationController!.value ==
                              animationController!.upperBound) {
                            
                            animationController!.reverse();
                            await GetStorageService.instance.box.write(
                                GetStorageService.instance.hasFaceTouch,
                                "false");
                          } else {
                            
                            
                            if (availableBiometrics.isNotEmpty) {
                              

                              NavigationService.instance.pushNamedRemoveUntil(
                                  routeName: NavigationConst
                                      .AFTER_PROFILE_PASS_CODE_VIEW);
                              //  animationController!.forward();
                            } else {
                              if (availableBiometrics.isEmpty) {}
                              await FaceAndTouchIDService.instance
                                  .onFaceAndTouch(context);
                            }
                          }
                        },
                        child: Container(
                          width: 42.h,
                          height: 25.h,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 1.h,
                                bottom: 1.h,
                                right: 1.h,
                                left: 1.h,
                                child: Container(
                                  width: 41.w,
                                  height: 21.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white.withOpacity(
                                        0.6,
                                      ),
                                      width: 3.h,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      16.h,
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 34.h *
                                        animationController!.value /
                                        animationController!.upperBound,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(
                                        0.6,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        16.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: animationController!.value,
                                child: Container(
                                  width: 25.h,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.012,
                                            ),
                                            blurRadius: 7.h,
                                            offset: Offset(
                                              0,
                                              3.h,
                                            )),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                        12.5.h,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return AlertyDialog3(
                        //         positionTopContainer: 3.4,
                        //         sizeHeightPainer: 3.3,
                        //         title: "",
                        //         titleDone: false,
                        //         buttonTextBottom: ''.locale,
                        //         subtitle: AutoSizeText("exit_app".locale),
                        //         onPressedLeft: () async {
                        //           
                        //           await context.introPr.exitApp(context);
                        //         },
                        //         onPressedRight: () {
                        //           Navigator.pop(context);
                        //         },
                        //         leftText: 'yes'.locale,
                        //         rightText: 'no'.locale,
                        //       );
                        //     });

                        //  await context.introPr.exitApp();
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
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.8),
                      ),
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertyDialog3(
                                positionTopContainer: 3.4,
                                sizeHeightPainer: 3.3,
                                title: "",
                                titleDone: false,
                                buttonTextBottom: ''.locale,
                                subtitle: AutoSizeText("exit_app".locale),
                                onPressedLeft: () async {
                                  
                                  await context.introPr.exitApp(context);
                                },
                                onPressedRight: () {
                                  Navigator.pop(context);
                                },
                                leftText: 'yes'.locale,
                                rightText: 'no'.locale,
                              );
                            });
                     //   await context.introPr.exitApp();
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
                        color:
                            ColorConst.instance.kButtonColor.withOpacity(0.86),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 15.h), // ! VERSIONN
                  ],
                ),
              );
            }),
      ),
    );
  }

  bottomSheet(
    BuildContext context,
  ) {
    final List name = ["O’zbekcha", "Русский"];
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
                  itemCount: name.length,
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
                              ),
                            ),
                            SizedBox(
                              width: context.w * 0.01,
                            ),
                            Text(
                              name[index].toString(),
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

  instanseLocalAuth() async {
    auth = await LocalAuthentication();
    availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      await animationController!.reverse();
      await GetStorageService.instance.box
          .write(GetStorageService.instance.hasFaceTouch, "false");
    }
    else{
      
    }
  }
}
