import 'package:flutter/services.dart';

class NativeFactory {

  static Future<bool> isEuropeUser() async {
    const platform = const MethodChannel("com.yuneec.fly");
    // Native channel
    bool result = false;
    try {
      result = await platform.invokeMethod("isChinese");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  static Future<String> getYuneecFly() async {
    const platform = const MethodChannel("com.yuneec.fly");
    String result = "";
    try {
      result = await platform.invokeMethod("yuneecFly");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
