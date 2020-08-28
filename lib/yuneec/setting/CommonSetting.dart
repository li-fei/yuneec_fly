import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fly/yuneec/mavlink/MavLinkUtils.dart';
import 'package:fly/yuneec/utils/Log.dart';
import 'package:fly/yuneec/utils/providers/settingsProviders.dart';
import 'package:provider/provider.dart';

class CommonSetting extends StatefulWidget {
  CommonSetting({Key key}) : super(key: key);

  @override
  _CommonSettingState createState() {
    return _CommonSettingState();
  }
}

class _CommonSettingState extends State<CommonSetting> {
  var distanceSelect;
  var areaSelect;
  var speedSelect;
  var temperatureSelect;
  var languageSelect;
  var matchColorSelect;
  var mapProviderSelect;
  var mapTypeSelect;
//  var settingSoundOnOffCheck = false;
  var settingNextStartupCheck = false;
  var settingUseRecomendCheck = false;
  var settingLowPowerCheck = false;
  var disableAllDataPersistenceCheck = false;
  var settingSaveLogAfterCheck = false;
  var settingSaveLogsEvenCheck = false;

  @override
  void initState() {
    super.initState();
    CommonSettingStatus().initCheckStatus(context);
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
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "单位(需重启)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0x90696969),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                border: Border.all(width: 1.5, color: Colors.white30),
              ),
              child: Column(
                children: [
                  distanceDropdownButton(),
                  areaDropdownButton(),
                  speedDropdownButton(),
                  temperatureDropdownButton(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "其他设置",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0x90696969),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                border: Border.all(width: 1.5, color: Colors.white30),
              ),
              child: Column(
                children: [
                  languageDropdownButton(),
                  matchColorDropdownButton(),
                  mapProviderDropdownButton(),
                  mapTypeDropdownButton(),
                  otherSettingSoundOnOff(),
                  otherSettingNextStartup(),
                  otherSettingUseRecomend(),
                  otherSettingLowPower(),
                  otherSettingTaskHighly(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Data Persistence",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0x90696969),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                border: Border.all(width: 1.5, color: Colors.white30),
              ),
              child: Column(
                children: [
                  disableAllDataPersistence(),
                  disableAllDataPersistenceExplain(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Telemetry Logs from Vehicle",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0x90696969),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                border: Border.all(width: 1.5, color: Colors.white30),
              ),
              child: Column(
                children: [
                  otherSettingSaveLogAfter(),
                  otherSettingSaveLogsEven(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget distanceDropdownButton() {
    return Container(
      padding: EdgeInsets.all(3.0),
      child: Row(
        children: [
          Text(
            "距离",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            width: ScreenUtil().setWidth(400.0),
            padding: EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: DropdownButtonHideUnderline(
                child: new DropdownButton(
              items: [
                'Feet',
                'Meters',
              ].map<DropdownMenuItem>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.0,
                    ),
                  ),
                );
              }).toList(),
              hint: new Text(
                'Feet',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12.0,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  distanceSelect = value;
                });
              },
              value: distanceSelect,
              elevation: 10,
              isDense: true,
              iconSize: 30.0,
            )),
          ),
        ],
      ),
    );
  }

  Widget areaDropdownButton() {
    return Container(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
            Text(
              "面积",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              width: ScreenUtil().setWidth(400.0),
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                  child: new DropdownButton(
                items: [
                  'SquareFeet',
                  'SquareMeters',
                  'SquareKilometers',
                  'Hectares',
                  'Acres',
                  'SquareMiles',
                ].map<DropdownMenuItem>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList(),
                hint: new Text(
                  'SquareFeet',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    areaSelect = value;
                  });
                },
                value: areaSelect,
                elevation: 10,
                isDense: true,
                iconSize: 30.0,
              )),
            ),
          ],
        ));
  }

  Widget speedDropdownButton() {
    return Container(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
            Text(
              "速度",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                  child: new DropdownButton(
                items: [
                  'Feet/second',
                  'Meters/second',
                  'Miles/hour',
                  'Kilometers/hour',
                  'Knots',
                ].map<DropdownMenuItem>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList(),
                hint: new Text(
                  'Feet/second',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    speedSelect = value;
                  });
                },
                value: speedSelect,
                elevation: 10,
                isDense: true,
                iconSize: 30.0,
              )),
            ),
          ],
        ));
  }

  Widget temperatureDropdownButton() {
    return Container(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
            Text(
              "温度",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                  child: new DropdownButton(
                items: [
                  'Celsius',
                  'Farenheit',
                ].map<DropdownMenuItem>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList(),
                hint: new Text(
                  'Celsius',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    temperatureSelect = value;
                  });
                },
                value: temperatureSelect,
                elevation: 10,
                isDense: true,
                iconSize: 30.0,
              )),
            ),
          ],
        ));
  }

  Widget languageDropdownButton() {
    return Container(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
            Container(
              width: 60.0,
              child: Text(
                "Language",
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                  child: new DropdownButton(
                items: [
                  'System',
                  'English',
                  '中文',
                ].map<DropdownMenuItem>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList(),
                hint: new Text(
                  'System',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    languageSelect = value;
                  });
                },
                value: languageSelect,
                elevation: 10,
                isDense: true,
                iconSize: 30.0,
              )),
            ),
          ],
        ));
  }

  Widget matchColorDropdownButton() {
    return Container(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
            Container(
              width: 60.0,
              child: Text(
                "配色方案",
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                  child: new DropdownButton(
                items: [
                  'Indoor',
                  'Outdoor',
                ].map<DropdownMenuItem>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList(),
                hint: new Text(
                  'Indoor',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    matchColorSelect = value;
                  });
                },
                value: matchColorSelect,
                elevation: 10,
                isDense: true,
                iconSize: 30.0,
              )),
            ),
          ],
        ));
  }

  Widget mapProviderDropdownButton() {
    return Container(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
            Container(
              width: 60.0,
              child: Text(
                "地图提供商",
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                  child: new DropdownButton(
                items: [
                  'Bing',
                  'Google',
                  'Statkart',
                  'Esri',
                  'Eniro',
                  'VWorld',
                ].map<DropdownMenuItem>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList(),
                hint: new Text(
                  'Bing',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    mapProviderSelect = value;
                  });
                },
                value: mapProviderSelect,
                elevation: 10,
                isDense: true,
                iconSize: 30.0,
              )),
            ),
          ],
        ));
  }

  Widget mapTypeDropdownButton() {
    return Container(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
            Container(
              width: 60.0,
              child: Text(
                "地图类型",
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                  child: new DropdownButton(
                items: [
                  'Street Map',
                  'Satellite Map',
                  'Hybrid Map',
                ].map<DropdownMenuItem>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList(),
                hint: new Text(
                  'Street Map',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    mapTypeSelect = value;
                  });
                },
                value: mapTypeSelect,
                elevation: 10,
                isDense: true,
                iconSize: 30.0,
              )),
            ),
          ],
        ));
  }

  otherSettingSoundOnOff() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: context.watch<CommonSettingStatus>().settingSoundOnOffCheck,
            activeColor: Colors.blue,
            checkColor: Colors.white,
            onChanged: (bool isChecked) {
              context.read<CommonSettingStatus>().setSettingSoundOnOffCheck(isChecked);
              MavLinkUtils().setSettingSoundOnOffCheck();
            },
          ),
          Text(
            "静音所有音频输出",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  otherSettingNextStartup() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: settingNextStartupCheck,
            activeColor: Colors.blue,
            checkColor: Colors.white,
            onChanged: (bool isChecked) {
              this.setState(() {
                settingNextStartupCheck = isChecked;
              });
            },
          ),
          Text(
            "下次启动时清除所有设置",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  otherSettingUseRecomend() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: settingUseRecomendCheck,
            activeColor: Colors.blue,
            checkColor: Colors.white,
            onChanged: (bool isChecked) {
              this.setState(() {
                settingUseRecomendCheck = isChecked;
              });
            },
          ),
          Flexible(
            child: Text(
              "Use recomended camera settings in missions",
              softWrap: true,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  otherSettingLowPower() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: settingLowPowerCheck,
            activeColor: Colors.blue,
            checkColor: Colors.white,
            onChanged: (bool isChecked) {
              this.setState(() {
                settingLowPowerCheck = isChecked;
              });
            },
          ),
          Text(
            "电量低于该电量时提示",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  otherSettingTaskHighly() {
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      child: Row(
        children: [
          Text(
            "默认任务高度: ",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 25.0,
              maxWidth: 60.0,
            ),
            child: getTaskHighlyTextField(),
          ),
        ],
      ),
    );
  }

  getTaskHighlyTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      maxLines: 1,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: '26.0',
//                prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.only(top: 2.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white),
      style: new TextStyle(
        fontSize: 12,
      ),
    );
  }

  disableAllDataPersistence() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: disableAllDataPersistenceCheck,
            activeColor: Colors.blue,
            checkColor: Colors.white,
            onChanged: (bool isChecked) {
              this.setState(() {
                disableAllDataPersistenceCheck = isChecked;
              });
            },
          ),
          Text(
            "Disable All Data Persistence",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  disableAllDataPersistenceExplain() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        "When Data Persistence is disabled, all telemetry logging and map tile caching is disabled and not writeen to disk.",
        softWrap: true,
        style: new TextStyle(
          color: Colors.white,
          fontSize: 10.0,
        ),
      ),
    );
  }

  otherSettingSaveLogAfter() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: settingSaveLogAfterCheck,
            activeColor: Colors.blue,
            checkColor: Colors.white,
            onChanged: (bool isChecked) {
              this.setState(() {
                settingSaveLogAfterCheck = isChecked;
              });
            },
          ),
          Flexible(
            child: Text(
              "Save log after each flight",
              softWrap: true,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  otherSettingSaveLogsEven() {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: settingSaveLogsEvenCheck,
            activeColor: Colors.blue,
            checkColor: Colors.white,
            onChanged: (bool isChecked) {
              this.setState(() {
                settingSaveLogsEvenCheck = isChecked;
              });
            },
          ),
          Flexible(
            child: Text(
              "Save logs even if vehivle was not armed",
              softWrap: true,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
