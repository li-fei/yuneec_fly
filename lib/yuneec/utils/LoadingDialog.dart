import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog extends StatefulWidget {
  String loadingText;
  bool outsideDismiss;
  Function dismissDialog;

  LoadingDialog(
      {Key key,
      this.loadingText = "loading...",
      this.outsideDismiss = true,
      this.dismissDialog})
      : super(key: key);

  @override
  State<LoadingDialog> createState() => LoadingDialogState();

  static show(BuildContext context){
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) => Theme(
        data: Theme.of(ctx).copyWith(dialogBackgroundColor: Colors.transparent),
        child: LoadingDialog(),
      ),
    );
  }

  static void dismiss(context) {
    Navigator.pop(context);
  }


}

class LoadingDialogState extends State<LoadingDialog> {
  dismissDialog() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
//    if (widget.dismissDialog != null) {
//      widget.dismissDialog(() {
//        Navigator.of(context).pop();
//      });
//    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.outsideDismiss ? dismissDialog : null,
      child: Material(
        type: MaterialType.transparency,
        child: new Center(
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: new Container(
              decoration: ShapeDecoration(
                color: Color(0x90696969),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      widget.loadingText,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  bool outsideDismiss = true;
  static void show(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) => Theme(
        data: Theme.of(ctx).copyWith(dialogBackgroundColor: Colors.transparent),
        child: Loading(),
      ),
    );
  }

  static void dismiss(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        outsideDismiss ? dismiss(context) : null;
      },
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x90696969),
              borderRadius: BorderRadius.circular(5),
            ),
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpinKitFadingCircle(
                  color: Colors.white,
                  size: 46.0,
                ),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Text(
                    "Loading",
                    style: new TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
