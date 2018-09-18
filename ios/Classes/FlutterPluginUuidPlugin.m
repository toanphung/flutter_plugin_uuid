#import "FlutterPluginUuidPlugin.h"
#import <flutter_plugin_uuid/flutter_plugin_uuid-Swift.h>

@implementation FlutterPluginUuidPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPluginUuidPlugin registerWithRegistrar:registrar];
}
@end
