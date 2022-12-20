import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:mobile/views/passcode_lock_screen/pass_code_auth_screen.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:provider/provider.dart';

import '../../core/init/internet/networ_change_manager.dart';
import '../../widgets/dialogs/intirnet_eror.dart';

class NoNetworkWidget extends StatefulWidget {
  Widget? child;
  NoNetworkWidget({super.key, this.child});
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
    // var route = ModalRoute.of(context);

    // 
    // 
    // 
    if (result == NetworkResult.off) {
      
    }else{
      
    }

    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    _networkResult == NetworkResult.off
        ? FocusManager.instance.primaryFocus?.unfocus()
        : null;

    return Stack(children: [
      _networkResult == NetworkResult.off
          ? AbsorbPointer(
              child: widget.child ?? SizedBox(),
            )
          :  widget.child ?? SizedBox(),
      AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        crossFadeState: _networkResult == NetworkResult.off
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Center(
          child: SizedBox(
            height: context.h,
            child: InternetEror(
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
      ),
    ]);
  }
}

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void waitForScreen(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onComplete.call();
    });
  }
}
