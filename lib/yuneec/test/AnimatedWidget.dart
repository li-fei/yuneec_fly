import 'package:flutter/material.dart';
import 'file:///F:/ASworkspace/yuneec_fly/lib/yuneec/setting/settingsWidget.dart';
import 'package:fly/yuneec/utils/EventBus.dart';
import 'package:fly/yuneec/utils/Global.dart';
import 'file:///F:/ASworkspace/yuneec_fly/lib/yuneec/utils/providers/Providers.dart';
import 'package:oktoast/oktoast.dart';

import '../camera/cameraRightWidget.dart';
import '../camera/cameraStateWidget.dart';
import '../cameraWidget.dart';
import '../map/amap.dart';
import '../mapWidget.dart';
import 'package:provider/provider.dart';

import 'amintionTest.dart';

class MainWeight extends StatefulWidget {
  MainWeightState mainWeightState;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    mainWeightState = MainWeightState();
    return mainWeightState;
  }

  MainWeight();
}

class MainWeightState extends State<MainWeight>
    with SingleTickerProviderStateMixin {
  AnimationController _controllerMinToMax;
//  AnimationController _controllerMaxToMin;
  Animation<double> widthMinToMax;
  Animation<double> widthMaxToMin;
  Animation<double> heightMinToMax;
  Animation<double> heightMaxToMin;

  var mapWidgetW = Global.defaultMapW;
  var mapWidgetH = Global.defaultMapH;
  var cameraWidgetW = Global.ScreenW;
  var cameraWidgetH = Global.ScreenH;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState()");
    initController();
    initAni();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerMinToMax.dispose();
//    _controllerMaxToMin.dispose();
    super.dispose();
  }

  void initController() {
    _controllerMinToMax = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
//    _controllerMaxToMin = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
  }

  void initAni() {
    widthMinToMax =
        creatTweenMinToMax(Global.defaultMapW, Global.ScreenW, "widthMinToMax");
    widthMaxToMin =
        creatTweenMaxToMin(Global.ScreenW, Global.defaultMapW, "widthMaxToMin");
    heightMinToMax =
        creatTweenMinToMax(Global.defaultMapH, Global.ScreenH, "heightMinToMax");
    heightMaxToMin =
        creatTweenMaxToMin(Global.ScreenH, Global.defaultMapH, "heightMaxToMin");
  }

  Animation<double> creatTweenMinToMax(double b, double e, String flag) {
    return Tween<double>(begin: b, end: e).animate(CurvedAnimation(
        parent: _controllerMinToMax,
        curve: Interval(
          0.0,
          0.3,
          curve: Curves.fastOutSlowIn,
        )))
      ..addListener(() {
//        print(" $flag ----- addListener()");
          setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Global.isMapFullScreen = true;
        }
        print("$flag ----- addStatusListener  -----  $status");
      });
  }

  Animation<double> creatTweenMaxToMin(double b, double e, String flag) {
    return Tween<double>(begin: b, end: e).animate(CurvedAnimation(
        parent: _controllerMinToMax,
        curve: Interval(
          0.0,
          0.3,
          curve: Curves.fastOutSlowIn,
        )))
      ..addListener(() {
//        print(" $flag ----- addListener()");
          setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Global.isMapFullScreen = false;
        }
        print("$flag ----- addStatusListener  -----  $status");
      });
  }

  Future _startAnimationMinToMax() async {
    Global.isMapFullScreen = true;
    try {
      print('_startAnimationMinToMax() ------- ');
      await _controllerMinToMax.forward();
    } on TickerCanceled {
      print('Animation Failed');
    }
  }

  Future _startAnimationMaxToMin() async {
    Global.isMapFullScreen = false;
    try {
      print('_startAnimationMaxToMin() ------- ');
      await _controllerMinToMax.forward();
    } on TickerCanceled {
      print('Animation Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    Positioned stateBarWidget = Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: Global.ScreenW,
        height: 50.0,
        color: Color(0x90696969),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () {
                print("stateBarWidget Yuneec onTap -------- ");
                showToast("YUENNC");
              },
              child: Text(
                "YUNEEC",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3),
              ),
            ),
            SizedBox(
              width: Global.ScreenW - 150,
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );

    Positioned mapWedget = Positioned(
      left: 0,
      bottom: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
//          duration: Duration(milliseconds: 500),
          width: Global.isMapFullScreen ? widthMaxToMin.value : widthMinToMax.value,
          height: Global.isMapFullScreen ? heightMaxToMin.value : heightMinToMax.value,
          color: Color(0x7000FF00),
//          child: Image.asset(
//            "assets/images/google_map.png",
//            fit: BoxFit.fill,
//          ),
        ),
        onTap: () {
          if (Global.isMapFullScreen) {
            _startAnimationMaxToMin();
          }else{
            _startAnimationMinToMax();
          }
//          Global.isMapViewTop = false;
//          mapWidgetW = Global.ScreenW;
//          mapWidgetH = Global.ScreenH;
//          cameraWidgetW = Global.defaultMapW;
//          cameraWidgetH = Global.defaultMapH;

//          setState(() {
//
//          });
        },
      ),
    );

    Positioned cameraWedget = Positioned(
      left: 0,
      bottom: 0,
      child: GestureDetector(
        child: Container(
//          duration: Duration(milliseconds: 500),
          width:
              0, //Global.isMapFullScreen ? widthMinToMax.value :widthMaxToMin.value,
          height:
              0, //Global.isMapFullScreen ? heightMinToMax.value :heightMaxToMin.value,
          color: Color(0x30FFD700),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              CameraWidget(),
              Container(
                margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                alignment: Alignment.topCenter,
                child: null,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                alignment: Alignment.centerRight,
                child: null,
              ),
            ],
          ),
        ),
        onTap: () {
//          if (!Global.isMapFullScreen) {
//            return;
//          }
//          Global.isMapFullScreen = false;
//          Global.isMapViewTop = true;
//          mapWidgetW = Global.defaultMapW;
//          mapWidgetH = Global.defaultMapH;
//          cameraWidgetW = Global.ScreenW;
//          cameraWidgetH = Global.ScreenH;
//          _startAnimation();
        },
      ),
    );

    Positioned settingsWedget = Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        child: null,
      ),
    );

    var mapTopWidget = Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
//        cameraWedget,
        mapWedget,
        stateBarWidget,
        settingsWedget,
      ],
    );

    var cameraTopWidget = Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        mapWedget,
        cameraWedget,
        stateBarWidget,
        settingsWedget,
      ],
    );

    var mainWidget = Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        context.watch<MapWidgetStatus>().isMapFullScreen
            ? mapWedget
            : cameraWedget,
//        Global.isMapViewTop ? cameraWedget : mapWedget,
//        Global.isMapViewTop ? mapWedget : cameraWedget,
        stateBarWidget,
        settingsWedget,
      ],
    );

    return OKToast(
      dismissOtherOnShow: true,
      position: ToastPosition.bottom,
      child: mapTopWidget,
//      child: context.watch<MapWidgetStatus>().isMapFullScreen
//          ? cameraTopWidget
//          : mapTopWidget,
    );
  }
}
