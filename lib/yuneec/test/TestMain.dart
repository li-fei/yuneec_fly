import 'package:flutter/material.dart';
import 'package:fly/yuneec/test/dioWidget.dart';
import 'package:fly/yuneec/test/url_launcher.dart';

class TestMain extends StatefulWidget {
  TestMain({Key key}) : super(key: key);

  @override
  _TestMainState createState() {
    return _TestMainState();
  }
}

class _TestMainState extends State<TestMain>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  var _selectType;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
        //getContainer(); //UrlLauncher(title: "Yuneec",);
//    DioWidget();
        DisDropdownButton();
  }

  Widget getLine() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20),
      color: Colors.yellow,
      width: 100.0,
      height: 2.0,
    );
  }

  Widget getContainer() {
    return Container(
      alignment: Alignment.topLeft,
//      padding: EdgeInsets.only(left: 100, top: 20),
      margin: EdgeInsets.only(left: 100, top: 20),
//      color: Colors.red,
      width: 500.0,
      height: 300.0,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: ExactAssetImage("assets/images/splash.png"),
            fit: BoxFit.fill),
//        color: Colors.green,
        border: Border.all(width: 3.0, color: Colors.red),
//        border: Border(bottom: BorderSide(width: 5.0, color: Colors.red)),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
//        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0)),
      ),
      child: getLine(),
    );
  }

  Widget DisDropdownButton() {
    return DropdownButtonHideUnderline(
        child: new DropdownButton(
      items:
          ['One', 'Two', 'Free', 'Four'].map<DropdownMenuItem>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: new Text('请选择'),
      onChanged: (value) {
        setState(() {
          _selectType = value;
          print(_selectType);
          print(value);
        });
      },
//      isExpanded: true,
      value: _selectType,
      elevation: 10, //设置阴影的高度
      style: new TextStyle(
        //设置文本框里面文字的样式
        color: Colors.black,
        fontSize: 12,
      ),
      isDense: true,
      iconSize: 30.0,
    ));
  }
}
