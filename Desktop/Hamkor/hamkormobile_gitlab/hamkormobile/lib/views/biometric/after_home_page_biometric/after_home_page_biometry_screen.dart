import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/biometric_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/10_home/container_decoration.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_first.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:provider/provider.dart';


class AfterHomePageBiometryScreen extends StatefulWidget {
  AfterHomePageBiometryScreen({Key? key}) : super(key: key);

  @override
  State<AfterHomePageBiometryScreen> createState() =>
      _AfterHomePageBiometryScreenState();
}

class _AfterHomePageBiometryScreenState
    extends State<AfterHomePageBiometryScreen> {
  @override
  late BiometricProvider biometricProvider;
  @override
  void didChangeDependencies() {
    biometricProvider = context.biometricPr;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    biometricProvider.clearInputField();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final BiometricProvider myProvider =
        Provider.of<BiometricProvider>(context, listen: false);
    return BaseView(
      viewModal: AfterHomePageBiometryScreen,
      onPageBuilder: (context, child) {
        return SwipeInGoBack(
          onWillPop: () async {
            NavigationService.instance.pushNamedRemoveUntil(
                routeName: NavigationConst.HOME_PAGE_VIEW);
            return false;
          },
          child: Scaffold(
            appBar: DefaultAppbar.getAppBar(
              "Биометрия",
              () {
                NavigationService.instance.pushNamedRemoveUntil(
                    routeName: NavigationConst.HOME_PAGE_VIEW);
              },
              context,
              true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.04,
                vertical: context.h * 0.04,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: context.h * 0.3,
                    padding: EdgeInsets.all(context.w * 0.04),
                    decoration:
                        ContainerDecorationComp.containerWithoutShadow(context),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Серия",
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: context.h * 0.08,
                                      child: TextFormField(
                                        //  keyboardType: TextInputType.text,
                                        controller:
                                            myProvider.seriyesController,
                                        onChanged: (value) =>
                                            myProvider.changeSeries(value),
                                        style: context.theme.bodyText1,
                                        maxLength: 2,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          isCollapsed: true,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.h, horizontal: 12.w),
                                          hintText: "AB",
                                          hintStyle: TextStyle(
                                            color: ColorConst
                                                .instance.kSecondaryTextColor,
                                            fontSize:
                                                FontSizeConst.instance.medium,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                context.h * 0.015),
                                            borderSide: BorderSide(
                                              color: ColorConst
                                                  .instance.kPrimaryColor,
                                              width: 0.5,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                context.h * 0.015),
                                            borderSide: BorderSide(
                                              color: ColorConst
                                                  .instance.kPrimaryColor,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: context.w * 0.03),
                              Expanded(
                                flex: 7,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Номер",
                                      style: TextStyle(
                                        color:
                                            ColorConst.instance.kMainTextColor,
                                        fontSize: FontSizeConst.instance.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: context.h * 0.08,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            myProvider.seriyesNumberController,
                                        onChanged: (value) => myProvider
                                            .changeSeriesNumber(value),
                                        inputFormatters: [
                                          MaskInputFormatter(mask: '#######'),
                                        ],
                                        style: context.theme.bodyText1,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          isCollapsed: true,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.h, horizontal: 12.w),
                                          hintText: "1234567",
                                          hintStyle: TextStyle(
                                            color: ColorConst
                                                .instance.kSecondaryTextColor,
                                            fontSize:
                                                FontSizeConst.instance.medium,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                context.h * 0.015),
                                            borderSide: BorderSide(
                                              color: ColorConst
                                                  .instance.kPrimaryColor,
                                              width: 0.5,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                context.h * 0.015),
                                            borderSide: BorderSide(
                                              color: ColorConst
                                                  .instance.kPrimaryColor,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: context.h * 0.02),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Дата рождения",
                                style: TextStyle(
                                  color: ColorConst.instance.kMainTextColor,
                                  fontSize: FontSizeConst.instance.small,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: myProvider.dateBirthController,
                                onChanged: (value) =>
                                    myProvider.changeDateBirth(value),
                                inputFormatters: [
                                  MaskInputFormatter(mask: '##-##-####'),
                                ],
                                style: context.theme.bodyText1,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  isCollapsed: true,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 17.h, horizontal: 12.w),
                                  hintText: "ДД.ММ.ГГГГ",
                                  hintStyle: TextStyle(
                                    color:
                                        ColorConst.instance.kSecondaryTextColor,
                                    fontSize: FontSizeConst.instance.medium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        context.h * 0.015),
                                    borderSide: BorderSide(
                                      color: context
                                              .biometricPrStream.isErorColor
                                          ? ColorConst.instance.kErrorColor
                                          : ColorConst.instance.kPrimaryColor,
                                      width: 0.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        context.h * 0.015),
                                    borderSide: BorderSide(
                                      color: ColorConst.instance.kPrimaryColor,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GradientButton(
                    text: "Продолжить",
                    width: double.infinity,
                    height: SizeConst.instance.buttonSize,
                    colorOpacity: context.biometricPrStream.isValid,
                    onPressed: () {
                      if (myProvider.isValid) {
                        context.biometricPr.isBioScreen = true;
                        
                        MaterialPageRoute(
                            builder: ((context) =>
                                AfterHomePageBiometricFirst()));
                        // NavigationService.instance.pushNamed(
                        //     routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_FIRST,);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
