import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
class IntroScreen extends StatefulWidget {
  const IntroScreen({ Key? key }) : super(key: key);
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}
class _IntroScreenState extends BaseState<IntroScreen> {
  @override
  void initState() {
      context.introPr.getLanguage();
     context.introPr.getOperators();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModal:IntroScreen,
      onPageBuilder: (context, widget) {
        return   Scaffold(
      body:   Center(
              child: SvgPicture.asset(ImageConst.instance.logo,
              color:ColorConst.instance.kPrimaryColor,),
            ),
      );
        },
    );
  }
}
