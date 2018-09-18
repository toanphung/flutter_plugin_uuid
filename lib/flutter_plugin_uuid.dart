import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginUuid {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_uuid');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get getUuid async {
    final String version = await _channel.invokeMethod('getUuid');
    return version;
  }
}
