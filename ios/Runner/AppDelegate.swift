import UIKit
import Flutter
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  YMKMapKit.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
      YMKMapKit.setApiKey("c51c245c-2638-40f7-a220-69da0a4c8cd1")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
