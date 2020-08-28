import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  TimerWidgetState state;
  @override
  TimerWidgetState createState() {
    if (state == null) {
      state = TimerWidgetState();
    }
    return state;
  }

  void stopVideo() {
    state.handleStop();
  }

  void startVideo() {
    state.handleStart();
  }
}

class TimerWidgetState extends State<TimerWidget> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;

  Timer timer;

  void handleStart() {
    timer = Timer.periodic(duration, (Timer t) {
      runTime();
    });
  }

  void runTime() {
    setState(() {
      secondsPassed = secondsPassed + 1;
    });
  }

  void handleStop() {
    setState(() {
      secondsPassed = 0;
      timer.cancel();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
//    if (timer == null) {
//      timer = Timer.periodic(duration, (Timer t) {
//        runTime();
//      });
//    }

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextContainer(
                label: 'H:',
                value: hours.toString().padLeft(2, '0'),
              ),
              CustomTextContainer(
                label: 'M:',
                value: minutes.toString().padLeft(2, '0'),
              ),
              CustomTextContainer(
                label: 'S:',
                value: seconds.toString().padLeft(2, '0'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  final String label;
  final String value;

  CustomTextContainer({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        color: Colors.black87,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "$label",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 9,
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 6, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
