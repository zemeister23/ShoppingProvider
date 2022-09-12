import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/app/app_constants.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/texts/text_const.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/init/cache/locale_manager.dart';
import 'package:mobile/core/init/internet/main_build.dart';
import 'package:mobile/core/init/lang/lang_manager.dart';
import 'package:mobile/core/init/notifier/provider_list.dart';
import 'package:mobile/models/min_version_model.dart';
import 'package:mobile/provider/theme_notifier_provider.dart';
import 'package:mobile/routes/route.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/version_control/min_version_service.dart';
import 'package:mobile/widgets/loading/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stack_trace/stack_trace.dart';
import 'core/constants/navigation/navigation_constant.dart';

BuildContext? kAppcontext;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    await _init();

    FlutterError.onError = (error) => flutterErrorHandler(error);

    runApp(
      MultiProvider(
        providers: [
          ...ApplicationProvider.instance.dependItems,
        ],
        child: EasyLocalization(
          child: MyApp(),
          saveLocale: true,
          fallbackLocale: Locale("ru", "RU"),
          startLocale: _platformCheck(),
          supportedLocales: LanguageManager.instance.supportedLocales,
          path: ApplicationConstants.LANG_ASSET_PATH,
        ),
      ),
    );
  }, (error, stack) {
    // if (kReleaseMode)
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
      reason: "fromMain -> ${StackTrace.current}",
    );
  });
}

void flutterErrorHandler(FlutterErrorDetails details) {
  FlutterError.dumpErrorToConsole(details);

  // Report to the application zone to report to Crashlytics.
  Zone.current.handleUncaughtError(details.exception, details.stack!);
}

Future _init() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Platform.isAndroid
  //     ? await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE)
  //     : () {};
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await LocaleManager.preferenceInit();
  await EasyLocalization.ensureInitialized();
  GetStorageService.instance.box.read(GetStorageService.instance.pageState) ==
          null
      ? GetStorageService.instance.box
          .write(GetStorageService.instance.pageState, "false")
      : null;
}

Locale _platformCheck() {
  return Platform.localeName.contains("en") ||
          Platform.localeName.contains("uz")
      ? Locale("uz", "UZ")
      : Platform.localeName.contains("ru")
          ? Locale("ru", "RU")
          : const Locale("uz", "UZ");
}

String _initialRouteCheck() {
  return GetStorageService.instance.box
              .read(GetStorageService.instance.pageState) ==
          "true"
      ? NavigationConst.RAZVILKA_PAGE_VIEW
      : GetStorageService.instance.box
                  .read(GetStorageService.instance.isLockScreenShowed) ??
              false
          ? NavigationConst.PASS_CODE_VIEW_FOR_MAIN
          : NavigationConst.INTRO_PAGE_VIEW;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: LoadingDialog.instance.loading(),
        child: MaterialApp(
          theme: Provider.of<ThemeNotifier>(context).currentTheme,
          title: TextConst.TITLE_APP,
          navigatorKey: NavigationService.instance.navigatorKey,
          onGenerateRoute: MyRoutes.instance.ongenerateRoute,
          initialRoute: _initialRouteCheck(),
          //  NavigationConst.INTRO_PAGE_VIEW,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: MainBuild.build,
        ),
      ),
      designSize: const Size(375, 812),
    );
  }
}
