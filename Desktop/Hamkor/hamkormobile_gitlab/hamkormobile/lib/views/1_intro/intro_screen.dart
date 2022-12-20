import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/init/cache/secure_storege.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends BaseState<IntroScreen> {
  @override
  void initState() {
    context.introPr.getOperators(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModal: IntroScreen,
      onPageBuilder: (context, widget) {
        return Scaffold(
          body: Center(
            child: SvgPicture.asset(
              ImageConst.instance.logo,
              color: ColorConst.instance.kPrimaryColor,
            ),
          ),
        );
      },
    );
  }
}
