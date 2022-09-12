import 'package:flutter/material.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

import '../../core/init/internet/networ_change_manager.dart';
import '../../widgets/dialogs/intirnet_eror.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({super.key});

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget> with StateMixin {
  late final INetworkChangeManager _networkChange;
  NetworkResult? _networkResult;
  @override
  void initState() {
    super.initState();
    _networkChange = NetworkChangeManager();

    waitForScreen(() {
      _networkChange.handleNetworkChange((result) {
        _updateView(result);
      });
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await _networkChange.checkNetworkFirstTime();
      _updateView(result);
    });
  }

  void _updateView(NetworkResult result) {
    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      crossFadeState: _networkResult == NetworkResult.off
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: Center(
        child: SizedBox(
          height: context.h,
          child: InternetEror(
            //  positionTopContainer: 3.2,
            // sizeHeightPainer: 3.5,
            title: "",
            subtitle: "no_internet_message".locale,
            buttonTextBottom: "try_again_internet".locale,
            onPressedTop: () async {
              var result = await _networkChange.checkNetworkFirstTime();
              try {
                bool v = await RefreshTokenApi.instance.postRefreshToken();
                await v == true
                    ? _updateView(NetworkResult.on)
                    : _updateView(NetworkResult.off);
              } catch (e) {
                throw Exception("INTERNET ERROR: $e\nRESULT: $result");
              }
            },
          ),
        ),
      ),
      secondChild: const SizedBox(),
    );
  }
}

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onComplete.call();
    });
  }
}
