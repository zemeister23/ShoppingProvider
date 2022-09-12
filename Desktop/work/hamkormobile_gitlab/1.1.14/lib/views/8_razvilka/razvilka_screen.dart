import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/razvilka_model.dart';
import 'package:mobile/models/store_action_model.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/outlined_buttun.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:provider/provider.dart';
import '../../core/init/cache/get_storege.dart';

class RazvilkaPage extends StatefulWidget {
  RazvilkaPage({Key? key}) : super(key: key) {
    GetStorageService.instance.box
        .write(GetStorageService.instance.pageState, "true");
  }

  @override
  State<RazvilkaPage> createState() => _RazvilkaPageState();
}

class _RazvilkaPageState extends State<RazvilkaPage> {
  Future<void>? _launched;
  late Uri toLaunch;
  Future<StoreActionModel>? storeActionData;
  @override
  void initState() {
    super.initState();
      context.biometricPr.isBioScreen = false;
    Provider.of<RazvilkaProvider>(context, listen: false).isBioService = false;
    storeActionData = Provider.of<RazvilkaProvider>(context, listen: false)
        .getStoreAction(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        appBar: DefaultAppbar.getAppBar("", () {}, context, false),
        backgroundColor: ColorConst.instance.kBackgroundColor,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const Spacer(flex: 15),
                SvgPicture.asset(
                  ImageConst.instance.miniLogo,
                  color: ColorConst.instance.kPrimaryColor,
                ),
                const Spacer(flex: 15),
                Expanded(
                  flex: 4,
                  child: GradientButton(
                    text: "add_card".locale,
                    width: context.w * 0.9,
                    height: context.h * 0.135,
                    colorOpacity: true,
                    onPressed: () {
                      NavigationService.instance
                          .pushNamed(routeName: "/9_addcard");
                    },
                  ),
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 4,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConst.instance.paddingW),
                        child: OutlinedButtonW(
                          opacity: 1,
                          text: "online_services".locale,
                          width: double.infinity,
                          height: SizeConst.instance.buttonSize,
                          onPressed: () {
                             context.biometricPr.isNavigateHomePage = false;
                            storeActionData!.then((value) {
                              Provider.of<RazvilkaProvider>(context,
                                      listen: false)
                                  .isBioService = true;
                              if (value.data!.action == 1) {
                                NavigationService.instance.pushNamed(
                                    routeName: NavigationConst.AFTER_RAZVILKA_BIOMETRIC_PAGE);
                              } else if (value.data!.action == 2) {

                                NavigationService.instance.pushNamed(
                                    routeName: NavigationConst.AFTER_RAZVILKA_BIOMETRIC_PAGE);
                              } else if (value.data!.action == 3) {
                                toLaunch = value.data!.link == null
                                    ? Uri.parse("")
                                    : Uri.parse(value.data!.link.toString());
                                NavigationService.instance.pushNamed(
                                    routeName:
                                        NavigationConst.VIEW_ADD_CARD_WEB_PAGE,
                                    data: toLaunch);
                              }
                            });
                          },
                        ),
                      ),
                      FutureBuilder<StoreActionModel>(
                        future: storeActionData,
                        builder:
                            ((context, AsyncSnapshot<StoreActionModel> snap) {
                          if (!snap.hasData) {
                            return SizedBox();
                          } else if (snap.hasError) {
                            return SizedBox();
                          } else {
                            toLaunch = snap.data!.data!.link == null
                                ? Uri.parse("")
                                : Uri.parse(snap.data!.data!.link.toString());
    
                            GetStorageService.instance.box.write(
                                GetStorageService.instance.toLaunch,
                                toLaunch.toString());
    
                            return snap.data!.data!.count! > 0
                                ? Positioned(
                                    top: -context.h * 0.012,
                                    right: context.h * 0.025,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          ColorConst.instance.kBackgroundColor,
                                      radius: context.h * 0.02,
                                      child: CircleAvatar(
                                        child: Text((snap.data!.data!.count ?? 0)
                                            .toString()),
                                        backgroundColor:
                                            ColorConst.instance.kOrangeColor,
                                        radius: context.h * 0.015,
                                      ),
                                    ))
                                : SizedBox();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
