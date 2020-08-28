import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/SPutils.dart';
import 'package:provider/provider.dart';

class DebugStatus with ChangeNotifier, DiagnosticableTreeMixin {

  bool enterSettingsAnimation = false;
  void setEnterSettingsAnimation(bool check) {
    enterSettingsAnimation = check;
    notifyListeners();
  }


  bool showVideoView = false;
  void setShowVideoView(bool check) {
    showVideoView = check;
    notifyListeners();
  }


}
