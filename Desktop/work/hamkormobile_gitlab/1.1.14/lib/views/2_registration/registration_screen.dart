import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/2_registration_provider.dart';
import 'package:mobile/service/device_service/device_service.dart';
import 'package:mobile/service/device_service/ip_info.dart';
import 'package:mobile/service/device_service/pacage_service.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/widgets/loading/loading_dialog.dart';
import '../../widgets/2_registation/language_button.dart';
import '../../widgets/2_registation/input_text.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({
    Key? key,
  }) : super(key: key) {
    GetStorageService.instance.box
        .write(GetStorageService.instance.isLocked, false);
    GetStorageService.instance.box
        .write(GetStorageService.instance.telNomer, "");
    GetStorageService.instance.box
        .write(GetStorageService.instance.isAuthenticated, false);
  }
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends BaseState<RegistrationScreen> {
  Map<String, dynamic> deviceInfo = {};
  Map<String, dynamic> packageInfo = {};
  final _storage = GetStorage();
  late RegistrationProvider registrationProvider;
  @override
  void didChangeDependencies() {
    registrationProvider = context.phoneRegisterPr;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    context.introPr.loading = false;
    init();
  }

  @override
  void dispose() {
    super.dispose();
    //  registrationProvider.clearPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: context.mq.copyWith(textScaleFactor: 1, boldText: false),
      child: Scaffold(
        backgroundColor: ColorConst.instance.kBackgroundColor,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: GestureDetector(
            onTap: () async {},
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConst.instance.horizPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80.h),
                  Text(
                    "registration".locale,
                    style: context.theme.headline1,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "enter_phone_number".locale,
                    style: context.theme.subtitle2,
                  ),
                  SizedBox(height: 20.h),
                  RegistrationInputField(),
                  const Spacer(flex: 70),
                  ChangeLanguageBottomSheet(),
                  const Spacer(flex: 1),
                  GradientButton(
                    colorOpacity: context.phoneRegisterPrStream.isValid,
                    onPressed: () async {
                      if (context.phoneRegisterPr.isValid) {
                        context.loaderOverlay.show();
                        await context.phoneRegisterPr.postPhoneNumber(
                          await context.phoneRegisterPr.telNumber.value!,
                          context,
                        );
                      } else {
                        ErrorMessage.instance.translationsEror(1030, context);
                      }
                    },
                    text: "continue".locale,
                    width: double.infinity,
                    height: 56.h,
                  ),
                  //    const Spacer(flex: 1),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future init() async {
    final deviceInfo = await DeviceInfoApi.getInfo();
    final packageInfo = await PackageInfoApi.getInfo();
    final ipAddress = await IpInfoApi.getIPAddress();

    final newPackageInfo = {
      'ipAddress': ipAddress,
      ...packageInfo,
    };

    if (!mounted) return;
    setState(() {
      this.packageInfo = newPackageInfo;
      this.deviceInfo = deviceInfo;
      _storage.write(GetStorageService.instance.deviceInfo,
          deviceInfo["phoneId"].toString());
      _storage.write(
          GetStorageService.instance.model, deviceInfo["model"].toString());
      _storage.write(GetStorageService.instance.systemName,
          deviceInfo["systemName"].toString());
      _storage.write(GetStorageService.instance.version,
          packageInfo["version"].toString());
    });
  }
}
