import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fly/yuneec/test/debug/Debug.dart';
import 'package:fly/yuneec/utils/LoadingDialog.dart';
import 'package:fly/yuneec/utils/Log.dart';
import 'package:fly/yuneec/setting/CommonSetting.dart';

class SettingsWidget extends StatefulWidget {
  @override
  SettingsWidgetState createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  BuildContext settingsContext;
  List list = [
    {"title": "通用设置", "index": 0,},
    {"title": "离线地图", "index": 1},
    {"title": "Update", "index": 2},
    {"title": "Flight Service", "index": 3},
    {"title": "GNSS RTK", "index": 4},
    {"title": "MockLink协议", "index": 5},
    {"title": "控制台", "index": 6},
    {"title": "概况", "index": 7},
    {"title": "固件", "index": 8},
    {"title": "Debug", "index": 9},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingsContext = context;
//    switchSettingsChildView(currentGroupIndex);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: GridView.count(
              padding: EdgeInsets.all(5.0),
              crossAxisCount: 1, //一行多少个
              scrollDirection: Axis.vertical, //滚动方向
              crossAxisSpacing: 10.0, // 左右间隔
              mainAxisSpacing: 15.0, // 上下间隔
              childAspectRatio: 1 / 0.4, //宽高比
              shrinkWrap: true,
              children: list.map((value) {
                return listitem(context, value);
              }).toList(),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, left: 10.0, right: 5.0, bottom: 5.0),
              child: getSettingsChildView(),
            )),
      ],
    );
  }

  Widget listitem(context, value) {
    var deviceSize = MediaQuery.of(context).size;
    return currentGroupIndex == value['index']
        ? RaisedButton(
            padding:EdgeInsets.all(0.0),
            color: Colors.blueGrey,
            onPressed: () {
              Log.logI('RaisedButton ${value}');
              updateGroupValue(value['index']);
            },
            child: Text(
              value['title'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : OutlineButton(
            padding:EdgeInsets.all(0.0),
            borderSide: new BorderSide(
                width: 1.5, color: Colors.blueGrey),
            onPressed: () {
              Log.logI('OutlineButton ${value}');
              updateGroupValue(value['index']);
            },
            child: Text(
              value['title'],
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 12.0,
              ),
            ),
          );
  }

  int currentGroupIndex = 0;

  void updateGroupValue(int index) {
    setState(() {
      switchSettingsChildView(index);
    });
  }

  Widget settingsChildView;
  Widget getSettingsChildView() {
    switchSettingsChildView(currentGroupIndex);
    return settingsChildView;
  }

  void switchSettingsChildView(int index) {
    switch (index) {
      case 0:
        settingsChildView = CommonSetting();
        break;
      case 1:
        settingsChildView = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(width: 1.5, color: Colors.blueGrey)),
          padding: EdgeInsets.all(1),
          child: null,
        );
        break;
      case 2:
        settingsChildView = Container(
          color: Colors.blue,
        );
        break;
      case 3:
        settingsChildView = Container(
          color: Colors.deepPurple,
        );
        break;
      case 4:
        showLoadingDialog(4);
        break;
      case 5:
        settingsChildView = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(width: 1, color: Colors.green)),
          padding: EdgeInsets.all(1),
          child: null,
        );
        break;
      case 9:
        settingsChildView = Debug();
        break;
    }
    currentGroupIndex = index;
  }

  Future<void> showLoadingDialog(int index) {
    if(index == currentGroupIndex){
      return null;
    }
    Future.delayed(Duration(milliseconds: 100), () {
      Loading.show(settingsContext);
    });

    Timer(Duration(seconds: 3), () {
      Log.logI("3秒后关闭......");
      setState(() {
        Loading.dismiss(settingsContext);
        settingsChildView = Container(
          color: Colors.amber,
        );
      });
    });
//    Future.delayed(Duration(seconds: 5), () {
//      Log.logI("5秒后关闭......");
//
//    });
  }
}
