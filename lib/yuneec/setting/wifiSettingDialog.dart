import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WifiSettingDialog extends StatefulWidget {
  WifiSettingDialog({Key key}) : super(key: key);

  @override
  _WifiSettingDialogState createState() {
    return _WifiSettingDialogState();
  }

  static void show(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return WifiSettingDialog();
        });
  }

  static void dismiss(context) {
    Navigator.of(context).pop();
  }
}

class _WifiSettingDialogState extends State<WifiSettingDialog> {
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
    return  Container(
      alignment: Alignment.topRight,
      child: Container(
        width: ScreenUtil().setWidth(800.0),
        height: ScreenUtil().setHeight(500.0),
        margin: EdgeInsets.only(
            top: ScreenUtil().setSp(150.0), right: ScreenUtil().setSp(50.0)),
        padding: EdgeInsets.all(ScreenUtil().setSp(10.0)),
        decoration: BoxDecoration(
          color: Color(0x80696969),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          border: Border.all(width: 1.5, color: Colors.black45),
        ),
      ),
    );

  }
}
