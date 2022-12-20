import UIKit
import Flutter
import YandexMapsMobile
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    YMKMapKit.setLocale("YOUR_LOCALE") 
    YMKMapKit.setApiKey("390c7ddb-0ad4-483b-bd03-32a4b888a1d0")
    GeneratedPluginRegistrant.register(with: self)
    // FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


    override func applicationWillEnterForeground(_ application: UIApplication) {
        hideHiddenViewWindow()
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        showHiddenViewWindow()
    }
    
    override func applicationWillResignActive(_ application: UIApplication) {
        showHiddenViewWindow()
    }
    
 
    override func applicationDidBecomeActive(_ application: UIApplication) {
        hideHiddenViewWindow()
    }
    
    
    
    private var privacyProtectionWindow: UIWindow? = UIWindow( )
    
    private func showHiddenViewWindow(){
        privacyProtectionWindow = UIWindow(frame: UIScreen.main.bounds)
        privacyProtectionWindow?.rootViewController = HiddenScreen()
        privacyProtectionWindow?.windowLevel = .alert + 1
        privacyProtectionWindow?.makeKeyAndVisible()
    }
    
    
    private func hideHiddenViewWindow(){
        privacyProtectionWindow?.isHidden = true
        privacyProtectionWindow = nil
    }
    
}
