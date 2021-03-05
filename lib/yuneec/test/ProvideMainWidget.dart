import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/EventBus.dart';
import 'package:fly/yuneec/utils/Global.dart';
import 'package:fly/yuneec/utils/providers/Providers.dart';
import 'package:oktoast/oktoast.dart';

import '../camera/cameraRightWidget.dart';
import '../camera/cameraStateWidget.dart';
import '../cameraWidget.dart';
import '../map/amap.dart';
import '../mapWidget.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState()  ------------  ");
  }

  @override
  Widget build(BuildContext context) {
    print("Widget build  ------------  ");

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
        child: AnimatedContainer(
          onEnd: () {
            print("mapWedget  AnimatedContainer onEnd ----- ");
//            context.read<MapWidgetStatus>().setMapFullScreen(true);
            Global.isMapFullScreen = true;
          },
          duration: Duration(milliseconds: 5000),
          width: Global.isMapFullScreen ? Global.ScreenW : Global.defaultMapW,
          height: Global.isMapFullScreen ? Global.ScreenH : Global.defaultMapH,
          color: Color(0x7000FF00),
//          child: Image.asset(
//            "assets/images/google_map.png",
//            fit: BoxFit.fill,
//          ),
        ),
        onTap: () {
          print("mapWedget   onTap   ----- ");
//          context.read<MapWidgetStatus>().setWidgetSize(Global.ScreenW, Global.ScreenH, Global.defaultMapW, Global.defaultMapH);
//          context
//              .read<MapWidgetStatus>()
//              .setMapWidgetWH(Global.ScreenW, Global.ScreenH);
//          context
//              .read<MapWidgetStatus>()
//              .setCameraWidgetWH(Global.defaultMapW, Global.defaultMapH);
          Future.delayed(Duration(milliseconds: 50), () {
            context.read<MapWidgetStatus>().setMapFullScreen(true);
          });
        },
      ),
    );

    Positioned cameraWedget = Positioned(
      left: 0,
      bottom: 0,
      child: GestureDetector(
        child: AnimatedContainer(
          onEnd: () {
            print("cameraWedget  AnimatedContainer onEnd ----- ");
//            context.read<MapWidgetStatus>().setMapFullScreen(false);
            Global.isMapFullScreen = false;
          },
          duration: Duration(milliseconds: 5000),
          width: !Global.isMapFullScreen ? Global.ScreenW : Global.defaultMapW,
          height: !Global.isMapFullScreen ? Global.ScreenH : Global.defaultMapH,
          color: Color(0x30FFD700),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            fit: StackFit.expand,
            children: [
              CameraWidget(),
              Container(
                margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                alignment: Alignment.topCenter,
                child: null,
              ),
              Container(
//                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                alignment: Alignment.centerRight,
                child: null,
              ),
            ],
          ),
        ),
        onTap: () {
          print("cameraWedget   onTap   ----- ");
//          context.read<MapWidgetStatus>().setWidgetSize(Global.defaultMapW, Global.defaultMapH,Global.ScreenW, Global.ScreenH);
//          context
//              .read<MapWidgetStatus>()
//              .setCameraWidgetWH(Global.ScreenW, Global.ScreenH);
//          context
//              .read<MapWidgetStatus>()
//              .setMapWidgetWH(Global.defaultMapW, Global.defaultMapH);
          Future.delayed(Duration(milliseconds: 50), () {
            context.read<MapWidgetStatus>().setMapFullScreen(false);
          });
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
      children: [
        cameraWedget,
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
      child: context.watch<MapWidgetStatus>().isMapFullScreen//Global.isMapFullScreen
          ? cameraTopWidget
          : mapTopWidget,
    );
  }
}
