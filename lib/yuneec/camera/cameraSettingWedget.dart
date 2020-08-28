import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CameraSettingWedget extends StatefulWidget {
  CameraSettingWedget({Key key}) : super(key: key);

  @override
  _CameraSettingWedgetState createState() {
    return _CameraSettingWedgetState();
  }
}

class _CameraSettingWedgetState extends State<CameraSettingWedget> {
  List listWidget;
  @override
  void initState() {
    super.initState();
    initDate();
  }

  void initDate() {
    listWidget = [
      {
        "type": 0,
        "title": "Thermal View Mode",
        "value": ["Off", "Blend", "Full", "Picture In Picture"],
        "defaultValue": null,
      },
      {
        "type": 1,
        "title": "Blend Opacity",
        "min": 0.0,
        "max": 100.0,
        "defaultValue": 0.0,
      },
      {
        "type": 0,
        "title": "ROI",
        "value": ["Center Area", "Sport"],
        "defaultValue": null,
      },
      {
        "type": 0,
        "title": "Image Scale",
        "value": ["1.1", "1.2", "1.3", "1.4", "1.5", "1.6", "1.7"],
        "defaultValue": null,
      },
      {
        "type": 0,
        "title": "Infrared Gain Mode",
        "value": ["High", "Low"],
        "defaultValue": null,
      },
      {
        "type": 0,
        "title": "Exposure Mode",
        "value": ["Auto", "Manual"],
        "defaultValue": null,
      },
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(1050.0),
      height: ScreenUtil().setHeight(550.0),
      margin: EdgeInsets.only(top: ScreenUtil().setSp(150.0)),
      padding: EdgeInsets.all(ScreenUtil().setSp(10.0)),
      decoration: BoxDecoration(
        color: Color(0x80696969),
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
        border: Border.all(width: 1.5, color: Colors.black45),
      ),
      child: ListView.builder(
        itemBuilder: (context, item) {
          return buildListData(context, listWidget[item]);
        },
        itemCount: listWidget.length,
      ),
    );
  }

  Widget buildListData(BuildContext context, listWidgetItem) {
    int type = listWidgetItem["type"];
    switch (type) {
      case 0:
        return getDropdownButton(listWidgetItem);
        break;
      case 1:
        return getSliderForTitle(listWidgetItem);
        break;
    }
  }

  Widget getDropdownButton(Map map) {
    return Container(
      padding: EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ScreenUtil().setWidth(400.0),
            child: Text(
              map["title"],
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(500.0),
            height: ScreenUtil().setHeight(100.0),
            padding: EdgeInsets.only(left: 15.0),
            margin: EdgeInsets.only(left: ScreenUtil().setSp(30.0)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: DropdownButtonHideUnderline(
                child: new DropdownButton(
              items: map["value"].map<DropdownMenuItem>((String value) {
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
                map["defaultValue"] == null
                    ? map["value"][0]
                    : map["defaultValue"],
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12.0,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  map["defaultValue"] = value;
                });
              },
              value: map["defaultValue"],
              elevation: 10,
              isDense: true,
              iconSize: 30.0,
            )),
          ),
        ],
      ),
    );
  }

  getSliderForTitle(Map map) {
    return Container(
      padding: EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ScreenUtil().setWidth(400.0),
            child: Text(
              map["title"] + ": " + map["defaultValue"].toString(),
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(500.0),
            height: ScreenUtil().setHeight(100.0),
            padding: EdgeInsets.only(left: 1.0),
            margin: EdgeInsets.only(left: ScreenUtil().setSp(30.0)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                valueIndicatorColor: Colors.blue,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Slider(
                value: map["defaultValue"],
                inactiveColor: Colors.black12,
                label: '${map["defaultValue"]}',
                min: map["min"],
                max: map["max"],
                divisions: 100,
                onChanged: (double) {
                  setState(() {
                    map["defaultValue"] = double.roundToDouble();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
