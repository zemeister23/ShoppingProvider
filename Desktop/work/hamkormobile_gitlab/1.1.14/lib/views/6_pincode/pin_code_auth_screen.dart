import 'package:flutter/material.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/provider/5_pin-code_auth_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/widgets/number_button.dart';
import 'package:mobile/widgets/pin_point.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinCodeAuthScreen extends StatefulWidget {
  const PinCodeAuthScreen({Key? key}) : super(key: key);
  @override
  State<PinCodeAuthScreen> createState() => _PinCodeAuthScreenState();
}

class _PinCodeAuthScreenState extends BaseState<PinCodeAuthScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PinCodeAuthProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = context.watch<PinCodeAuthProvider>();

    return BaseView(
      viewModal: PinCodeAuthScreen,
      onPageBuilder: (BuildContext context, value) {
        return WillPopScope(
            child: Scaffold(
              appBar: DefaultAppbar.getAppBar(
                  "pin_code_installation".locale, null, context, false),
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: context.w * 0.09),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "sign_in_code".locale,
                                  style: context.theme.subtitle2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: PinPoint(
                                  myProvider.pinList,
                                  myProvider.list,
                                  myProvider.pinCode,
                                  false,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Center(
                                child: NumButton(pageState: true),
                              ),
                            ),
                            SizedBox(height: SizeConst.instance.minSize),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConst.instance.paddingW),
                      child: GradientButton(
                        height: SizeConst.instance.buttonSize,
                        width: double.infinity,
                        onPressed: () {
                          if (Provider.of<PinCodeAuthProvider>(context,
                                      listen: false)
                                  .pinCode
                                  .length >=
                              4) {
                            NavigationService.instance.pushNamedRemoveUntil(
                                routeName: "/7_checkpincode");
                          }
                        },
                        text: "continue".locale,
                        colorOpacity: context
                                    .watch<PinCodeAuthProvider>()
                                    .pinCode
                                    .length >=
                                4
                            ? true
                            : false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onWillPop: () async => false);
      },
    );
  }
}
