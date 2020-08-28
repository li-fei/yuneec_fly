import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'debugProviders.dart';

class Debug extends StatefulWidget {
  Debug({Key key}) : super(key: key);

  @override
  _DebugState createState() {
    return _DebugState();
  }
}

class _DebugState extends State<Debug> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(width: 1.5, color: Colors.blueGrey)),
        padding: EdgeInsets.all(1),
        child: Column(
          children: [setEnterSettingsAnimation(), setShowVideoView()],
        ),
      ),
    );
  }

  setEnterSettingsAnimation() {
    return Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0x90696969),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                border: Border.all(width: 1.5, color: Colors.white30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RadioListTile<int>(
              value: 1,
              groupValue:
                  context.watch<DebugStatus>().enterSettingsAnimation ? 1 : 2,
              onChanged: (int value) {
                context.read<DebugStatus>().setEnterSettingsAnimation(true);
              },
              secondary: Icon(
                Icons.chevron_right,
                color: Colors.white30,
              ),
              title: new Text("进设置动画1"),
              subtitle: new Text("平移..."),
              dense: true,
              activeColor: Colors.white,
              isThreeLine: false,
              selected: true,
            ),
            Divider(
              color: Colors.grey[300],
              height: 1,
            ),
            RadioListTile<int>(
              value: 2,
              groupValue:
                  context.watch<DebugStatus>().enterSettingsAnimation ? 1 : 2,
              onChanged: (int value) {
                context.read<DebugStatus>().setEnterSettingsAnimation(false);
              },
              secondary: Icon(
                Icons.chevron_right,
                color: Colors.white30,
              ),
              title: new Text("进设置动画2"),
              subtitle: new Text("淡入淡出..."),
              dense: true,
              activeColor: Colors.white,
              isThreeLine: false,
              selected: true,
            ),
          ],
        ));
  }

  bool showVideoView = false;
  setShowVideoView() {
    return Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0x90696969),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                border: Border.all(width: 1.5, color: Colors.white30),
        ),
        child: Row(
          children: [
            Checkbox(
              value: context.watch<DebugStatus>().showVideoView,
              activeColor: Colors.blue,
              checkColor: Colors.white,
              onChanged: (bool isChecked) {
                if(showVideoView){
                  showVideoView = false;
                }else{
                  showVideoView = true;
                }
                context.read<DebugStatus>().setShowVideoView(showVideoView);
              },
            ),
            Flexible(
              child: Text(
                "Show Video View.",
                softWrap: true,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ));
  }
}
