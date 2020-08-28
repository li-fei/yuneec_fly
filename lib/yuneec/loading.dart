import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'dart:async';

import 'package:fly/yuneec/utils/Global.dart';
import 'package:fly/yuneec/utils/Log.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingState createState() => new LoadingState();
}

class LoadingState extends State<LoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Log.logI("Yuneec程序启动......");
      Navigator.of(context).pushReplacementNamed("app");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    init();
    return Container(
//      decoration: BoxDecoration(),
      child: Image.asset(
        "assets/images/splash.png",
        fit: BoxFit.fill,
      ),
    );
  }

  void getScreenWH(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double ratio = queryData.devicePixelRatio;
    Global.ScreenW = queryData.size.width;
    Global.ScreenH = queryData.size.height;
    Global.defaultMapW = Global.ScreenW / 4;
    Global.defaultMapH = Global.ScreenH / 4;
    Log.logI("W:" +
        Global.ScreenW.toString() +
        "  H:" +
        Global.ScreenH.toString() +
        "  ratio:" +
        ratio.toString());
  }

  void init() {
    ScreenUtil.init(context, width: 1920, height: 1080);
    getScreenWH(context);
  }
}
