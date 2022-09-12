import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/service/api_service/home_service/client_cards_service.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class InputTest extends StatefulWidget {
  const InputTest({Key? key}) : super(key: key);

  @override
  State<InputTest> createState() => _InputTestState();
}

class _InputTestState extends State<InputTest> {
  @override
  void initState() {
    context.homePr.getClientCards(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: data()),
            ElevatedButton(onPressed: () {}, child: Text("ok"))
          ],
        ),
      ),
    );
  }

  data() {
    if (context.homePr.responseClientName.data!.firstName!.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return Future.delayed(Duration(seconds: 5), () {
        Text(context.homePr.responseClientCards!.data!.cards![0].balance
            .toString());
      });
    }
  }
}
//