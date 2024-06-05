import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }
      
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
      
    GMSServices.provideAPIKey("AIzaSyCGzdWSRPmwqh8Lor3UsWsEO9HArG9u64s")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
