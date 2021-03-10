import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/EventBus.dart';
import 'package:fly/yuneec/utils/Global.dart';
import 'dart:async';

import 'map/amap.dart';
import 'package:fly/yuneec/map/GoogleMap.dart';

class MapWidget extends StatefulWidget {
  @override
  MapWidgetState createState() => new MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
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
//       child: AmapWidget(),
      child: GoogleMap(),
    );
  }
}
