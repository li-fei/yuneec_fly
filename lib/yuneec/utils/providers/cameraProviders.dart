import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/SPutils.dart';
import 'package:provider/provider.dart';
import '../Global.dart';

class CameraSettingStatus with ChangeNotifier, DiagnosticableTreeMixin {

  bool showCameraSetting = false;
  void setShowCameraSetting(bool show) {
    showCameraSetting = show;
    notifyListeners();
  }


}
