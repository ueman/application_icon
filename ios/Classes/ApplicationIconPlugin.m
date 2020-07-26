#import "ApplicationIconPlugin.h"
#if __has_include(<application_icon/application_icon-Swift.h>)
#import <application_icon/application_icon-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "application_icon-Swift.h"
#endif

@implementation ApplicationIconPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftApplicationIconPlugin registerWithRegistrar:registrar];
}
@end
