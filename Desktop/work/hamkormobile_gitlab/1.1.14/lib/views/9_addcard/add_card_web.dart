import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddCardWeb extends StatelessWidget {
  final Uri snap;
  AddCardWeb({Key? key, required this.snap}) : super(key: key) {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  WebViewController? _webViewController;
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: DefaultAppbar.getAppBar("Hamkor Store", () {
      // if(context.biometricPr.isNavigateHomePage){
      //   NavigationService.instance.pushNamedRemoveUntil(routeName: NavigationConst.HOME_PAGE_VIEW);
      // }
      // else{
      //  NavigationService.instance.pushNamedRemoveUntil(routeName: NavigationConst.RAZVILKA_PAGE_VIEW);
      // }
      //   }, context, true),
      body: SafeArea(
        child: WebView(
          initialUrl: snap.toString(),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) async {},
        ),
      ),
    );
  }
}
