import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter/services.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'dart:developer' as developer;

import '../../core/init/internet/networ_change_manager.dart';
import '../../widgets/dialogs/intirnet_eror.dart';

class NoNetworkWidgetMainScreen extends StatefulWidget {
  const NoNetworkWidgetMainScreen({super.key});

  @override
  State<NoNetworkWidgetMainScreen> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidgetMainScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InternetEror(
        //  positionTopContainer: 3.2,
        // sizeHeightPainer: 3.5,

        title: "",
        subtitle: "no_internet_message".locale,
        buttonTextBottom: "try_again_internet".locale,
        onPressedTop: () async {
          try {
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.mobile ||
                (connectivityResult == ConnectivityResult.wifi)) {
              NavigationService.instance
                  .pushNamedRemoveUntil(routeName: _initialRouteCheck());
            }
          } catch (e) {
            throw Exception("INTERNET ERROR: $e\nRESULT:");
          }
        },
      ),
    );
  }

  String _initialRouteCheck() {
    return GetStorageService.instance.box
                .read(GetStorageService.instance.pageState) ==
            "true"
        ? NavigationConst.RAZVILKA_PAGE_VIEW
        : GetStorageService.instance.box
                    .read(GetStorageService.instance.isLockScreenShowed) ??
                false
            ? NavigationConst.PASS_CODE_VIEW
            : NavigationConst.INTRO_PAGE_VIEW;
  }
}
