import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/12_web_view_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddCardWeb extends StatefulWidget {
  final Uri snap;
  AddCardWeb({Key? key, required this.snap}) : super(key: key) {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  State<AddCardWeb> createState() => _AddCardWebState();
}

class _AddCardWebState extends State<AddCardWeb> {
  WebViewController? _webViewController;

  Completer<WebViewController> _controller = Completer<WebViewController>();

  bool isDownload = true;

  @override
  Widget build(BuildContext context) {
    var webPr = Provider.of<WebViewProvider>(context);

    // print(GetStorageService.instance.box
    //     .read(GetStorageService.instance.accessToken));

    // print(GetStorageService.instance.box
    //     .read(GetStorageService.instance.refreshToken));
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (await _webViewController!.canGoBack()) {
              _webViewController!.goBack();
            }
            return true;
          },
          child: WebView(
            initialUrl: widget.snap.toString(),
            gestureNavigationEnabled: true,
            gestureRecognizers: [
              Factory(() => EagerGestureRecognizer()),
              Factory(() => VerticalDragGestureRecognizer()),
              Factory(() => HorizontalDragGestureRecognizer()),
            ].toSet(),
            javascriptMode: JavascriptMode.unrestricted,
            allowsInlineMediaPlayback: true,
            debuggingEnabled: true,
            onWebResourceError: (error) {
              Navigator.pop(context);
            },
            navigationDelegate: (NavigationRequest nq) async {
             if (nq.url.split("/").last == "close-browser") {
                // context.homePr.changeIndex(0);
              Navigator.pop(context);
              }

              if (nq.url.split("?")[0].endsWith(".pdf")) {
                launchUrlString(
                  nq.url,
                  mode: LaunchMode.externalApplication,
                ).then((value) {
                  
                }).catchError((e) {
                  
                });

                return NavigationDecision.prevent;
              } else {
                return NavigationDecision.navigate;
              }
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
}
