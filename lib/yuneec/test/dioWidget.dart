import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/DioRequest.dart';
import 'package:fly/yuneec/utils/LoadingDialog.dart';
import 'package:fly/yuneec/utils/Log.dart';

class DioWidget extends StatefulWidget {
  DioWidget({Key key}) : super(key: key);

  @override
  _DioWidgetState createState() {
    return _DioWidgetState();
  }
}

class _DioWidgetState extends State<DioWidget> {
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

    Widget scrollView = CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(2.0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
//                Text("123456"),
                FutureBuilder(
                  future: DioRequest.dioGet(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Response> snapshot) {
                    if (snapshot.hasData) {
                      Response response = snapshot.data;
                      return Text("${response.data.toString()}");
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: Loading(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );

    Widget singleChildScrollView = SingleChildScrollView(
      child: FutureBuilder(
        future: DioRequest.dioGet(),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.hasData) {
            Response response = snapshot.data;
            return Text("${response.data.toString()}");
          } else {
            return Container(
              alignment: Alignment.center,
              child: Loading(),
            );
          }
        },
      ),
    );

    return Container(
      alignment: Alignment.center,
      child: singleChildScrollView,
    );
  }
}

//class DioRequest {
//  static final Dio dio = Dio();
//  static Future<Response> dioGet() async {
//    await Future.delayed(Duration(seconds: 3), () {});
//    try {
//      Response response = await dio.get("http://www.baidu.com");
//      return response;
//    } catch (e) {
//      print(e);
//    }
//  }
//}
