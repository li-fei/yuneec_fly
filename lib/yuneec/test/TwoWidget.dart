import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/providers/Providers.dart';
import 'package:provider/provider.dart';

class TwoWidget extends StatefulWidget {
  @override
  TwoWidgetState createState() => new TwoWidgetState();
}

class TwoWidgetState extends State<TwoWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text(context.watch<MapWidgetStatus>().isMapFullScreen ? "全屏" : "左下角",
          style: TextStyle(fontSize: 20.0, color: Colors.red)),
    );
  }
}
