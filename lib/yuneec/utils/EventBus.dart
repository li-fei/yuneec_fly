import 'package:event_bus/event_bus.dart';

/// 创建EventBus
EventBus eventBus = EventBus();

class ThemeColorEvent {
  String colorStr;
  ThemeColorEvent(this.colorStr);
}

class MapSizeToFullEvent {}

class CameraSizeToFullEvent {}

class ShowCameraSettingEvent {
  bool show;
  ShowCameraSettingEvent(this.show);
}
