import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/views/biometric/after_web_view_biometric/after_web_view_biometric_first.dart';
import 'package:mobile/views/biometric/after_web_view_biometric/after_web_view_biometric_last.dart';
import 'package:mobile/views/biometric/after_web_view_biometric/after_web_view_camera_for_android_screen.dart';
import 'package:mobile/views/passcode_lock_screen/after_profile_pass_code_screen.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/routes/router/custom_material_page_route.dart';
import 'package:mobile/views/10_home/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:mobile/views/10_home/service/service_screen.dart';
import 'package:mobile/views/11_stories/stories_screen.dart';
import 'package:mobile/views/12_story/story_screen.dart';
import 'package:mobile/views/13_transactions/sucses_transactions.dart';
import 'package:mobile/views/13_transactions/transactions_screen.dart';
import 'package:mobile/views/15_profile/profile_screen.dart';
import 'package:mobile/views/14_smstransaction/sms_transactions_screen.dart';
import 'package:mobile/views/16_viewoferta/vire_oferta_screen.dart';
import 'package:mobile/views/1_intro/intro_screen.dart';
import 'package:mobile/views/2_registration/registration_screen.dart';
import 'package:mobile/views/3_smscode/sms_code_screen.dart';
import 'package:mobile/views/5_ofertaalert/oferta_alert_screen.dart';
import 'package:mobile/views/6_pincode/pin_code_auth_screen.dart';
import 'package:mobile/views/8_checkpincode/check_pin_code_screen.dart';
import 'package:mobile/views/8_razvilka/razvilka_screen.dart';
import 'package:mobile/views/9_addcard/add_card_screen.dart';
import 'package:mobile/views/9_addcard/add_card_web.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_camera_for_android.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_first.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_last.dart';
import 'package:mobile/views/biometric/after_razvilka_biometric/after_razvilka_biometry_screen.dart';
import 'package:mobile/views/biometric/after_razvilka_biometric/after_razvilka_biometry_screen_camera_for_android.dart';
import 'package:mobile/views/biometric/after_razvilka_biometric/after_razvilka_biometry_screen_first.dart';
import 'package:mobile/views/biometric/after_razvilka_biometric/after_razvilka_biometry_screen_last.dart';
import 'package:mobile/views/example_test_screen/input_text_feld_1.dart';
import 'package:mobile/views/internet_error/internet_error_screen.dart';
import 'package:mobile/views/internet_error/main_intiernet_error_screen.dart';
import 'package:mobile/views/map/bankomats_screen.dart';
import 'package:mobile/views/map/fillials_screen.dart';
import 'package:mobile/views/map/map_screen.dart';
import 'package:mobile/views/map/test_scree.dart';
import 'package:mobile/views/passcode_lock_screen/pass_code_auth_screen.dart';
import 'package:mobile/widgets/navigation_not_found_widget.dart';
import '../views/4_oferta/oferta_screen.dart';

class MyRoutes {
  static final MyRoutes _instance = MyRoutes._init();
  static MyRoutes get instance => _instance;
  MyRoutes._init();

  Route ongenerateRoute(RouteSettings settings) {
    Object? args = settings.arguments;
    
    switch (settings.name) {
    

      case NavigationConst.PASS_CODE_VIEW:
        return normalNavigate(PassCodeAuthScreen(
          isPop: args as bool,
        ));
      case NavigationConst.PASS_CODE_VIEW_FOR_MAIN:
        return normalNavigate(PassCodeAuthScreen());
      case NavigationConst.AFTER_PROFILE_PASS_CODE_VIEW:
        return normalNavigate(AfterProfilePassCodeAuthScreen());

      case NavigationConst.HOME_PAGE_VIEW:
        return normalNavigate(BottomNavBarScreen());
      case NavigationConst.EXAMPLE_PAGE_VIEW:
        return normalNavigate(InputTest());
      case NavigationConst.INTRO_PAGE_VIEW:
        return normalNavigate(const IntroScreen());
      case NavigationConst.REGISTRATION_PAGE_VIEW:
        return normalNavigate(RegistrationScreen());

      case NavigationConst.SMS_CODE_REGISTRATION_PAGE_VIEW:
        return normalNavigate(SmsRegisterScreen(true, false));
      case NavigationConst.ADD_CARD_SMS_CODE_REGISTRATION_PAGE_VIEW:
        return normalNavigate(SmsRegisterScreen(false, true));
      case NavigationConst.OFERTA_ALERT_PAGE_VIEW:
        return normalNavigate(const OfertaAlertScreen());
      case NavigationConst.OFERTA_PAGE_VIEW:
        return normalNavigate(const OfertaScreen());
      case NavigationConst.PINCODE_PAGE_VIEW:
        return normalNavigate(const PinCodeAuthScreen());
      case NavigationConst.ChECK_PIN_CODE_PAGE_VIEW:
        return normalNavigate(const CheckPinCodeScreen());
      case NavigationConst.RAZVILKA_PAGE_VIEW:
        return normalNavigate(RazvilkaPage());
      case NavigationConst.ADD_CARD_PAGE_VIEW:
        return normalNavigate(AddCardPage());
      case NavigationConst.CLIENT_REGISTER_PAGE_VIEW:
        return normalNavigate(SmsRegisterScreen(false, false));
      case NavigationConst.TRANLATIONS_PAGE_VIEW:
        return normalNavigate(TransactionScreen());
      case NavigationConst.STORIES_PAGE_VIEW:
        return normalNavigate(StoriesScreen());
      case NavigationConst.STORY_PAGE_VIEW:
        return normalNavigate(HistoryScreen());
      case NavigationConst.SUCSES_TRANSACTIONS_PAGE_VIEW:
        return normalNavigate(SucsesTransactionsScreen());
      case NavigationConst.SMS_TRANSACTION_PAGE_VIEW:
        return normalNavigate(SmsTransactionsScreen());
      case NavigationConst.PROFILE_PAGE_VIEW:
        return normalNavigate(ProfileScreen());
      case NavigationConst.VIEW_OFERTA_PAGE_VIEW:
        return normalNavigate(ViewOffertaScreen());
      case NavigationConst.VIEW_BRANCHES_PAGE_VIEW:
        return normalNavigate(Fillials());
      case NavigationConst.VIEW_BANCOMATES_PAGE_VIEW:
        return normalNavigate(BankomatsScreen());
      case NavigationConst.VIEW_ADD_CARD_WEB_PAGE:
        return normalNavigate(AddCardWeb(snap: args as Uri));
      case NavigationConst.MAP_PAGE_VIEW:
        return normalNavigate(MapScreen());

      case NavigationConst.SERVICE_VIEW:
        return normalNavigate(ServiceScreen());
      case NavigationConst.SERVICE_VIEW_AD:
        return normalNavigate(ServiceScreen(isAdScreen: true));

      case NavigationConst.AFTER_RAZVILKA_ABIOMETRIC_FIRST:
        return normalNavigate(AfterRazvilkaBiometricFirst());
      // case NavigationConst.BIOMETRIC_CAMERA:
      //   return normalNavigate(BiometricCamera());
      case NavigationConst.AFTER_RAZVILKA_BIOMETRIC_CAMERA_ANDROID:
        return normalNavigate(AfterRazvilkaBiometricCameraAndroid(
          isSmile: false,
          resolution: "720",
          cameras: args as List<CameraDescription>,
        ));
      case NavigationConst.AFTER_RAZVILKA_BIOMETRIC_LAST:
        return normalNavigate(AfterRazvilkaBiometricLast(
          imagePath: args as String,
          isSmile: false,
        ));

      case NavigationConst.AFTER_RAZVILKA_BIOMETRIC_PAGE:
        // 
        return normalNavigate(AfterRazvilkaBiometryScreen());

      case NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_FIRST:
        return normalNavigate(AfterHomePageBiometricFirst());

      case NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_FIRST_AD:
        return normalNavigate(AfterHomePageBiometricFirst());
      case NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_CAMERA_ANDROID:
        return normalNavigate(AfterHomePageBiometricCameraAndroid(
          isSmile: false,
          resolution: "720",
          cameras: args as List<CameraDescription>,
        ));
      case NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_LAST:
        return normalNavigate(AfterHomePageBiometricLast(
          resolution: "720",
          isSmile: false,
          imagePath: args as String,
        ));
      case NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_PAGE:
        return normalNavigate(AfterHomePageBiometryScreen());

      case NavigationConst.INTERNET_ERROR_PAGE:
        return normalNavigate(NoNetworkWidgetMainScreen());
     
     
      case NavigationConst.AFTER_WEB_VIEW_BIOMETRIC_FIRST_PAGE:
        return normalNavigate(AfterWebViewBiometricFirst());
    
    
    case NavigationConst.AFTER_WEB_VIEW_BIOMETRIC_CAMERA_PAGE:
        return normalNavigate(AfterWebViewBiometricCameraAndroid(
          isSmile: false,
          resolution: "720",
          cameras: args as List<CameraDescription>));
   case NavigationConst.AFTER_WEB_VIEW_BIOMETRIC_LAST_PAGE:
        return normalNavigate(AfterWebViewBiometricLast(imagePath: '', isSmile: false, resolution: '',));
   
   
   
     default:
        return normalNavigate(const NavigationNotFoundWidget());
    }
  }
  // * FOR EASY NAVIGATION :)
  MaterialPageRoute normalNavigate(Widget widget) => MaterialPageRoute(
        builder: (ctx) => widget,
      );
  // * CUSTOM NAVIGATION
  MaterialPageRoute customNavigate(Widget widget) => CustomMaterialPageRoute(
        builder: (ctx) => widget,
      );
}
