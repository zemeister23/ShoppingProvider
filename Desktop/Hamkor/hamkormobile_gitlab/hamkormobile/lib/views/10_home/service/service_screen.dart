import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/models/store_action_model.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mobile/core/extensions/context_extension.dart';

import '../../../provider/12_web_view_provider.dart';

class ServiceScreen extends StatefulWidget {
  final bool? isBackButtonEnabled;
  bool isAdScreen = false;
  ServiceScreen({
    Key? key,
    this.isBackButtonEnabled = true,
    this.isAdScreen = false,
  }) : super(key: key) {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  WebViewController? _webViewController;

  Completer<WebViewController> _controller = Completer<WebViewController>();
  late final Future<StoreActionModel> data;

  @override
  void initState() {
    init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var webPr = Provider.of<WebViewProvider>(context);
    context.biometricPr.ctx = context;
    return Scaffold(
      //   appBar: DefaultAppbar.getAppBar(
      //     "Hamkor Store",
      //     () {
      //    //   Navigator.pop(context);
      //  },
      //     context,
      //     widget.isBackButtonEnabled!,
      //   ),
      body: SafeArea(
        child: FutureBuilder<StoreActionModel>(
          future: data,
          builder: (context, AsyncSnapshot<StoreActionModel> snap) {
            if (!snap.hasData) {
              return LoadingPage(true);
            } else if (snap.hasError) {
              return Center(
                child: Text(snap.error.toString()),
              );
            } else {
              final data = snap.data!.data;

              if (data!.action == 3) {
                return WillPopScope(
                  onWillPop: () async {
                    if (await _webViewController!.canGoBack()) {
                      _webViewController!.goBack();
                    }
                    return true;
                  },
                  child: WebView(
                    initialUrl: data.link.toString(),
                    gestureNavigationEnabled: true,
                    gestureRecognizers: [
                      Factory(() => EagerGestureRecognizer()),
                      Factory(() => VerticalDragGestureRecognizer()),
                      Factory(() => HorizontalDragGestureRecognizer()),
                    ].toSet(),
                    javascriptMode: JavascriptMode.unrestricted,
                    allowsInlineMediaPlayback: true,
                    debuggingEnabled: true,
                    navigationDelegate: (NavigationRequest nq) async {
                      if (nq.url.split("/").last == "close-browser") {
                        if (widget.isAdScreen) {
                          Navigator.pop(context);
                        } else {
                          context.homePr.changeIndex(0);
                        }
                      }

                      return NavigationDecision.navigate;
                    },
                    onWebViewCreated: (WebViewController webViewController) {
                      _webViewController = webViewController;
                      _controller.complete(webViewController);
                    },
                    onProgress: (int progress) {},
                    onPageStarted: (String url) async {
                      await controlUrl(url, context, webPr);
                    },
                    onPageFinished: (String url) async {},
                  ),
                );
              } else {
                return LoadingPage(false);
              }
            }
          },
        ),
      ),
    );
  }

  controlUrl(String url, BuildContext context, WebViewProvider webPr) {
    if (url.contains("/physical/biometry")) {
      for (var i = 0; i < url.split("&").length; i++) {
        if (url.split("&")[i].contains("ctoken")) {
          webPr.cToken = url.split("&")[i].split("=").last;
        }
        if (url.split("&")[i].contains("oauth")) {
          webPr.oauth = url.split("&")[i].split("=").last;
        }
        if (url.split("&")[i].contains("failure_url")) {
          webPr.failureUrl = url.split("&")[i].split("=").last;
        }
      }

      NavigationService.instance.pushNamed(
          routeName: NavigationConst.AFTER_WEB_VIEW_BIOMETRIC_FIRST_PAGE);
    } else {}
  }

  void init(BuildContext context) {
    data = Provider.of<RazvilkaProvider>(context, listen: false)
        .getStoreAction(context)
        .then((value) {
      if (value.data!.action == 1) {
        context.biometricPr.isNavigateHomePage = true;
        Uri toLaunch = value.data!.link == null
            ? Uri.parse("")
            : Uri.parse(value.data!.link.toString());

        NavigationService.instance.pushNamed(
            routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_PAGE,
            data: toLaunch);
      } else if (value.data!.action == 2) {
        context.biometricPr.isNavigateHomePage = true;
        Provider.of<RazvilkaProvider>(context, listen: false).action =
            value.data!.action!;
        if (widget.isAdScreen) {
          NavigationService.instance.pushNamed(
            routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_FIRST_AD,
            data: context,
          );
        } else {
          NavigationService.instance.pushNamed(
            routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_FIRST,
            data: context,
          );
        }
      }
      return value;
    });
  }
}
