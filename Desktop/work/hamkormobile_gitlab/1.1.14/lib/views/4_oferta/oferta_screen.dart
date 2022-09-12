import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/provider/4_oferta_provider.dart';
import 'package:mobile/views/4_oferta/_widget/offerta_data.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:provider/provider.dart';

class OfertaScreen extends StatefulWidget {
  const OfertaScreen({Key? key}) : super(key: key);
  @override
  State<OfertaScreen> createState() => _OfertaScreenState();
}

class _OfertaScreenState extends BaseState<OfertaScreen> {
  @override
  void initState() {
    Provider.of<OfertaProvider>(context, listen: false).checkbox = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.instance.kBackgroundColor,
      appBar: DefaultAppbar.getAppBar("oferta".locale, null, context, true),
      body: OffertaData(),
    );
  }
}
