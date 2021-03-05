import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fly/yuneec/camera/cameraSettingWedget.dart';
import 'package:fly/yuneec/stateBarWidget.dart';
import 'package:fly/yuneec/test/debug/debugProviders.dart';
import 'package:fly/yuneec/utils/EventBus.dart';
import 'package:fly/yuneec/utils/Global.dart';
import 'package:fly/yuneec/utils/Log.dart';
import 'package:fly/yuneec/utils/providers/cameraProviders.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:fly/yuneec/setting/settingsWidget.dart';
import 'package:fly/yuneec/camera/cameraRightWidget.dart';
import 'package:fly/yuneec/camera/cameraStateWidget.dart';
import 'package:fly/yuneec/cameraWidget.dart';
import 'package:fly/yuneec/mapWidget.dart';
import 'package:fly/yuneec/utils/providers/settingsProviders.dart';

class MainWeight extends StatefulWidget {
  MainWeightState mainWeightState;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    mainWeightState = MainWeightState();
    return mainWeightState;
  }
}

class MainWeightState extends State<MainWeight> {

  StreamSubscription streamSubscription;

  var mapW = Global.defaultMapW;
  var mapH = Global.defaultMapH;
  var cameraWidgetW = Global.ScreenW;
  var cameraWidgetH = Global.ScreenH;
  double settingsWidth = 400.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamSubscription = eventBus.on<ShowCameraSettingEvent>().listen((event) {
      Log.logI("-- eventBus ************ ShowCameraSettingEvent ------ {$event.show}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {

    Positioned mapWedget = Positioned(
      left: 0,
      bottom: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: mapW,
          height: mapH,
//          color: Color(0x7000FF00),
//          child: Image.asset(
//            "assets/images/google_map.png",
//            fit: BoxFit.fill,
//          ),
          child: Stack(
            children: [
              MapWidget(),
              Visibility(
                visible: !Global.isMapFullScreen,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          eventBus.fire(MapSizeToFullEvent());
          if (Global.isMapFullScreen) {
            return;
          }
          setState(() {
            Global.isMapFullScreen = true;
            Global.isMapViewTop = false;
            mapW = Global.ScreenW;
            mapH = Global.ScreenH;
            cameraWidgetW = Global.defaultMapW;
            cameraWidgetH = Global.defaultMapH;
          });
        },
      ),
    );

    Positioned cameraWedget = Positioned(
      left: 0,
      bottom: 0,
      child: GestureDetector(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: cameraWidgetW,
          height: cameraWidgetH,
          color: Color(0x30FFD700),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            fit: StackFit.expand,
            children: [
              CameraWidget(),
              Container(
                margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                alignment: Alignment.topCenter,
                child: CameraStateWidget(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                alignment: Alignment.centerRight,
                child: CameraRightWidget(),
              ),
            ],
          ),
        ),
        onTap: () {
          if (!Global.isMapFullScreen) {
            return;
          }
          setState(() {
            Global.isMapFullScreen = false;
            Global.isMapViewTop = true;
            mapW = Global.defaultMapW;
            mapH = Global.defaultMapH;
            cameraWidgetW = Global.ScreenW;
            cameraWidgetH = Global.ScreenH;
          });
        },
      ),
    );

    var mainWidget = Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Global.isMapViewTop ? cameraWedget : mapWedget,
        Global.isMapViewTop ? mapWedget : cameraWedget,
        StateBarWidget(),
        getSettingsWedget(),
        getCameraSettingWedget(),
      ],
    );

    return OKToast(
      dismissOtherOnShow: true,
      position: ToastPosition.bottom,
      child: mainWidget,
    );
  }

  getCameraSettingWedget() {
    return Container(
      alignment: Alignment.center,
      child: context.watch<CameraSettingStatus>().showCameraSetting
          ? CameraSettingWedget()
          : null,
    );
  }

  getSettingsWedget() {
    AnimatedOpacity settings = AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: context.watch<StateBarStatus>().isShowSettingsWidget ? 1 : 0,
        child: Visibility(
          visible: context.watch<StateBarStatus>().isShowSettingsWidget,
          child: Container(
            width: settingsWidth,
            height: Global.ScreenH - 50,
            color: Color.fromARGB(200, 0, 0, 0),
            child: SettingsWidget(),
          ),
        ));
    var setting = TweenAnimationBuilder(
      curve: Curves.linear,
      duration: Duration(milliseconds: 300),
      tween: Tween(
          begin: Offset(0.0, 0.0),
          end: Offset(context.watch<StateBarStatus>().settingsOffset, 0.0)),
      builder: (BuildContext context, value, Widget child) {
        return Transform.translate(
          offset: value,
          child: Container(
            width: settingsWidth,
            height: Global.ScreenH - 50,
            color: Color.fromARGB(200, 0, 0, 0),
            alignment: Alignment.topLeft,
            child: SettingsWidget(),
          ),
        );
      },
    );
    return Positioned(
      right: 0,
      bottom: 0,
      child: context.watch<DebugStatus>().enterSettingsAnimation
          ? setting
          : settings,
    );
  }

}
