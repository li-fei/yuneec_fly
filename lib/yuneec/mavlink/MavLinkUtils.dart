import 'package:fly/yuneec/utils/Toast.dart';

class MavLinkUtils {
  static MavLinkUtils instance;
  static MavLinkUtils getInstance() {
    if (instance == null) {
      instance = MavLinkUtils();
    }
  }

  void setSettingSoundOnOffCheck() {
    showDefalutToast("setSettingSoundOnOffCheck...");
  }
}
