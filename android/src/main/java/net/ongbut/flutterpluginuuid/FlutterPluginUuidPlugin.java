package net.ongbut.flutterpluginuuid;

import android.provider.Settings;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterPluginUuidPlugin */
public class FlutterPluginUuidPlugin implements MethodCallHandler {
  /** Plugin registration. */
  private Registrar mRegistrar;
  FlutterPluginUuidPlugin(Registrar registrar){
    mRegistrar = registrar;
  }
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_plugin_uuid");
    channel.setMethodCallHandler(new FlutterPluginUuidPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if(call.method.equals("getUuid")){
      String uuid = Settings.Secure.getString(mRegistrar.context().getContentResolver(), Settings.Secure.ANDROID_ID);
      result.success(uuid);
    }
    else {
      result.notImplemented();
    }
  }

}
