import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fly/yuneec/setting/wifiSettingDialog.dart';
import 'package:fly/yuneec/utils/Global.dart';
import 'package:fly/yuneec/utils/Log.dart';
import 'package:fly/yuneec/utils/NativeFactory.dart';
import 'package:fly/yuneec/utils/Toast.dart';
import 'package:provider/provider.dart';

import 'utils/providers/settingsProviders.dart';

class StateBarWidget extends StatefulWidget {
  StateBarWidget({Key key}) : super(key: key);

  @override
  _StateBarWidgetState createState() {
    return _StateBarWidgetState();
  }
}

class _StateBarWidgetState extends State<StateBarWidget> {
  bool showSettingsWidget = false;
  double settingsOffset = 400.0;

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
    return getStateBar();
  }

  Widget getStateBar() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: Global.ScreenW,
        height: 50.0,
        color: Color(0x90696969),
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Log.logI("stateBarWidget Yuneec onTap -------- ");
                      showDefalutToast("YUENNC");
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setSp(20.0)),
                      child: Text(
                        "YUNEEC",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showMenuSettings();
//                CameraSettingDialog.show(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setSp(70.0)),
                      child: Icon(Icons.menu),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showWaypoint();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setSp(70.0)),
                      child: Icon(Icons.gesture),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setSp(70.0)),
                      child: Icon(Icons.message),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  "Connected",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setSp(70.0)),
                        child: Icon(Icons.signal_cellular_4_bar),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setSp(70.0)),
                        child: Icon(
                          Icons.battery_charging_full,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showWifiSettings();
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setSp(70.0)),
                        child: Icon(Icons.wifi,color: Colors.white,),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (showSettingsWidget) {
                          showSettingsWidget = false;
                        } else {
                          showSettingsWidget = true;
                        }
                        context
                            .read<StateBarStatus>()
                            .setShowSettingsSetting(showSettingsWidget);

                        if (settingsOffset == 400.0) {
                          settingsOffset = 0;
                        } else {
                          settingsOffset = 400.0;
                        }
                        context
                            .read<StateBarStatus>()
                            .setSettingsOffset(settingsOffset);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setSp(70.0)),
                        child: Icon(Icons.settings),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMenuSettings() {
//    showDefalutToast("MENU");
    NativeFactory.isEuropeUser().then((value) => showDefalutToast(value.toString()));
  }

  void showWaypoint() {
//    showDefalutToast("Waypoint");
    NativeFactory.getYuneecFly().then((value) => showDefalutToast(value));
  }

  void showWifiSettings() {
//    showDefalutToast("WifiSettings");
    WifiSettingDialog.show(context);
  }


}
