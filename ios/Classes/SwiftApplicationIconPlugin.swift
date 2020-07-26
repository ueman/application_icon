import Flutter
import UIKit

public class SwiftApplicationIconPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "application_icon", binaryMessenger: registrar.messenger())
    let instance = SwiftApplicationIconPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "bitmapIcon" {
        if let bytes = appIconAsBitmap() {
            result(FlutterStandardTypedData(bytes:bytes))
        }
    }
    result(nil)
  }
}


func appIconAsBitmap() -> Data? {
    let imageName = getHighResolutionAppIconName()
    let image = UIImage(named: imageName!)
    return image?.pngData()
}

func getHighResolutionAppIconName() -> String? {
    guard let infoPlist = Bundle.main.infoDictionary else { return nil }
    guard let bundleIcons = infoPlist["CFBundleIcons"] as? NSDictionary else { return nil }
    guard let bundlePrimaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? NSDictionary else { return nil }
    guard let bundleIconFiles = bundlePrimaryIcon["CFBundleIconFiles"] as? NSArray else { return nil }
    guard let appIcon = bundleIconFiles.lastObject as? String else { return nil }
    return appIcon
}

