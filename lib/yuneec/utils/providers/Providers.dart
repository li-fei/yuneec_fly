import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/SPutils.dart';
import 'package:provider/provider.dart';
import '../Global.dart';

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  String title = "";
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void setTitle(String t) {
    title = t;
    notifyListeners();
  }
}

class MapWidgetStatus with ChangeNotifier, DiagnosticableTreeMixin {
  bool isMapFullScreen = false;

  void setMapFullScreen(bool fullScreen) {
    isMapFullScreen = fullScreen;
    Global.isMapFullScreen = fullScreen;
    notifyListeners();
  }

  var mapWidgetW = Global.defaultMapW;
  var mapWidgetH = Global.defaultMapH;
  var cameraWidgetW = Global.ScreenW;
  var cameraWidgetH = Global.ScreenH;

  void setMapWidgetWH(double w, double h) {
    mapWidgetW = w;
    mapWidgetH = h;
    notifyListeners();
  }

  void setCameraWidgetWH(double w, double h) {
    cameraWidgetW = w;
    cameraWidgetH = h;
    notifyListeners();
  }

  void setWidgetSize(double mapW, double mapH, double cameraW, double cameraH) {
    mapWidgetW = mapW;
    mapWidgetH = mapH;
    cameraWidgetW = cameraW;
    cameraWidgetH = cameraH;
    notifyListeners();
  }
}

