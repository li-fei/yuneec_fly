import 'package:flutter/material.dart';
import 'package:fly/yuneec/camera/cameraRightWidget.dart';
import 'dart:async';

import 'package:fly/yuneec/utils/Global.dart';
import 'package:fly/yuneec/utils/Log.dart';

import 'camera/cameraStateWidget.dart';
import 'test/debug/debugProviders.dart';
import 'utils/EventBus.dart';
import 'package:provider/provider.dart';

import 'yuneecPlayer.dart';

class CameraWidget extends StatefulWidget {
  @override
  CameraWidgetState createState() => new CameraWidgetState();
}

class CameraWidgetState extends State<CameraWidget> {
  StreamSubscription streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamSubscription = eventBus.on<MapSizeToFullEvent>().listen((event) {
      Log.logI("-- eventBus ************ MapSizeToFullEvent ------");
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
    // TODO: implement build

    return Container(child: getVideoView());
  }

  getVideoView() {
    if (context.watch<DebugStatus>().showVideoView) {
      return YuneecPlayer();
    } else {
      return Image.asset(
        "assets/images/wallpaper_1.jpg",
        fit: BoxFit.cover,
      );
    }
  }
}
