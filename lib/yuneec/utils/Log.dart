//import 'package:oktoast/oktoast.dart';

class Log {
  static bool showLog = true;
  static bool showLogToast = true;

  static void logI(String info) {
    if (showLog) {
      print("${new DateTime.now()}: " + info);
    }
  }

  static void logToast(String info) {
    if (showLogToast) {
//      showToast(info);
    }
  }
}
