import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobile/views/passcode_lock_screen/pass_code_auth_screen.dart';
import 'package:provider/provider.dart';
import '../../../provider/check_pass_code_provider.dart';
import '../../../provider/lock_timer_provider.dart';
import '../../../provider/map_provider.dart';
import '../../init/cache/get_storege.dart';

class BaseView<T> extends StatefulWidget {
  final T? viewModal;
  final Widget Function(BuildContext context, T value)? onPageBuilder;
  final Function(T model)? onModelReady;
  final VoidCallback? onDispose;
  const BaseView({
    Key? key,
    required this.viewModal,
    required this.onPageBuilder,
    this.onModelReady,
    this.onDispose,
  }) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> with WidgetsBindingObserver {
  Timer? _timer = Timer(Duration(), () {});
  num _durationOfLock = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.onModelReady != null) widget.onModelReady!(widget.viewModal);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (GetStorageService.instance.box
            .read(GetStorageService.instance.isLockScreenShowed) ??
        false) {
      if (state == AppLifecycleState.detached) {
        await GetStorageService.instance.box
            .write(GetStorageService.instance.isLocked, true);
        setState(() {});
        return;
      }
      if (state == AppLifecycleState.inactive) {
        Provider.of<CheckPassCodeProvider>(context, listen: false)
            .changeIsPopToFalse();
        if (_durationOfLock >= 40) {
          GetStorageService.instance.box
              .write(GetStorageService.instance.isLocked, true);
          setState(() {});
          return;
        }
      }
      if (state == AppLifecycleState.paused) {
        Provider.of<CheckPassCodeProvider>(context).changeIsPopToFalse();

        _timer = Timer.periodic(
          Duration(seconds: 40),
          (timer) {
            _durationOfLock += 1;
            if (_durationOfLock >= 40) {
              GetStorageService.instance.box
                  .write(GetStorageService.instance.isLocked, true);
              _durationOfLock = 0;
              setState(() {});
              _timer!.cancel();
              return;
            }
          },
        );
      }
      if (state == AppLifecycleState.resumed) {
        _durationOfLock = 0;
        setState(() {});
        _timer!.cancel();
        return;
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return GetStorageService.instance.box
                .read(GetStorageService.instance.isLocked) ??
            false
        ? PassCodeAuthScreen(isPop: false)
        : GestureDetector(
            child: widget.onPageBuilder!(context, widget.viewModal),
            onPanDown: context.watch<MapProvider>().isMapScreen
                ? null
                : (s) {
                    Provider.of<LockProvider>(context, listen: false)
                        .initializeTimer();
                  },
          );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer!.cancel();
    if (widget.onDispose != null) widget.onDispose!();
    super.dispose();
  }
}
