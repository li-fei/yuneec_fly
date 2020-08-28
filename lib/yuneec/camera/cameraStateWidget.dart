import 'package:flutter/material.dart';
import 'package:fly/locale/translations.dart';
import 'dart:async';

import 'package:fly/yuneec/utils/Global.dart';

class CameraStateWidget extends StatefulWidget {
  cameraStateWidgetState state;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    state = new cameraStateWidgetState();
    return state;
  }
}

class cameraStateWidgetState extends State<CameraStateWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
//      decoration: BoxDecoration(),
      width: Global.isMapFullScreen ? 0 : 300.0,
      height: Global.isMapFullScreen ? 0 : 45.0,
      decoration: ShapeDecoration(
        color: Color(0x90696969),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3.0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          cameraParamColumn("AE", 'Auto'),
          cameraParamColumn("EV", '0'),
          cameraParamColumn("WB", 'Auto'),
          cameraParamColumn("Metering", 'Center'),
          cameraParamColumn(Translations.getString(context, 'sd_card'), '1G/16G'),
        ],
      ),
    );
  }

  Column cameraParamColumn(String name, String value) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
//        new Icon(icon, color: color),
        new Container(
            margin: const EdgeInsets.only(top: 1.0),
            height: 20.0,
            child: Center(
              child: Text(
                name,
                style: new TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            )),
        new Container(
          margin: const EdgeInsets.only(top: 3.0),
          child: new Text(
            value,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
