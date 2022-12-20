import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/app/app_constants.dart';
import 'package:mobile/core/constants/texts/text_const.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_adapter_service.dart';
import 'package:mobile/core/init/cache/locale_manager.dart';
import 'package:mobile/core/init/internet/main_build.dart';
import 'package:mobile/core/init/lang/lang_manager.dart';
import 'package:mobile/core/init/notifier/provider_list.dart';
import 'package:mobile/provider/theme_notifier_provider.dart';
import 'package:mobile/routes/route.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/map/test_scree.dart';
import 'package:mobile/widgets/loading/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/navigation/navigation_constant.dart';
import 'dart:developer' as developer;

BuildContext? kAppcontext;

void main() async {
  await dotenv.load(fileName: ".env");
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult connectionStatus = await _connectivity.checkConnectivity();
  runZonedGuarded<Future<void>>(() async {
    await _init();

    FlutterError.onError = (error) => flutterErrorHandler(error);
    runApp(
      MultiProvider(
        providers: [
          ...ApplicationProvider.instance.dependItems,
        ],
        child: EasyLocalization(
          child: MyApp(connectionStatus: connectionStatus),
          saveLocale: true,
          fallbackLocale: Locale("ru", "RU"),
          startLocale: _platformCheck(),
          supportedLocales: LanguageManager.instance.supportedLocales,
          path: ApplicationConstants.LANG_ASSET_PATH,
        ),
      ),
    );
  }, (error, stack) {
    if (kReleaseMode)
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
  Zone.current.handleUncaughtError(details.exception, details.stack!);
}

Future _init() async {
 
    
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HiveAdapterService.instance.addAdapter();
 
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

class MyApp extends StatefulWidget {
  ConnectivityResult connectionStatus;
  MyApp({required this.connectionStatus});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
            initialRoute: Platform.isIOS
                ? _initialRouteCheck()
                : widget.connectionStatus != ConnectivityResult.none
                    ? _initialRouteCheck()
                    : NavigationConst.INTERNET_ERROR_PAGE,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: MainBuild.build,
          )),
      designSize: const Size(375, 812),
    );
  }
}
