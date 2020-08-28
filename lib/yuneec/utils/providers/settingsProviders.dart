import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/SPutils.dart';
import 'package:provider/provider.dart';

class CommonSettingStatus with ChangeNotifier, DiagnosticableTreeMixin {
  void initCheckStatus(BuildContext context) {
    SPutils.getBool(SPutils.key_settingSoundOnOffCheck).then((value) => {
          settingSoundOnOffCheck = (value == null ? false : value),
          context.read<CommonSettingStatus>().setSettingSoundOnOffCheck(settingSoundOnOffCheck),
        });
  }

  bool settingSoundOnOffCheck = false;
  void setSettingSoundOnOffCheck(bool check) {
    SPutils.saveBool(SPutils.key_settingSoundOnOffCheck, check);
    settingSoundOnOffCheck = check;
    notifyListeners();
  }
}

class StateBarStatus with ChangeNotifier, DiagnosticableTreeMixin {
  bool isShowSettingsWidget = false;
  void setShowSettingsSetting(bool show) {
    isShowSettingsWidget = show;
    notifyListeners();
  }

  double settingsOffset = 400.0;
  void setSettingsOffset(double offset) {
    settingsOffset = offset;
    notifyListeners();
  }
}
