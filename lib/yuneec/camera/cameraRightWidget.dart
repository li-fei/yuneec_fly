import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fly/yuneec/camera/cameraSettingDialog.dart';
import 'package:fly/yuneec/utils/Global.dart';
import 'package:fly/yuneec/utils/Log.dart';
import 'package:fly/yuneec/utils/providers/cameraProviders.dart';
import 'package:fly/yuneec/widget/SimpleImageButton.dart';
import 'package:fly/yuneec/widget/TimerWidget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class CameraRightWidget extends StatefulWidget {
  cameraRightWidgetState state;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    state = new cameraRightWidgetState();
    return state;
  }

}

AnimationController controller;
Animation animation;

class cameraRightWidgetState extends State<CameraRightWidget>
    with TickerProviderStateMixin {
  bool showCameraSettingWidget = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      width: Global.isMapFullScreen ? 0 : 65.0,
      height: Global.isMapFullScreen ? 0 : 200.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(width: 1.5, color: Colors.black45)),
      padding: EdgeInsets.all(1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SimpleImageButton(
              width: 36.0,
              normalImage: Global.isCurrentPhotoMode
                  ? "assets/images/ic_cam_dir_photomode.png"
                  : "assets/images/ic_cam_dir_videomode.png",
              pressedImage: Global.isCurrentPhotoMode
                  ? "assets/images/ic_cam_dir_photomode.png"
                  : "assets/images/ic_cam_dir_videomode.png",
              onPressed: () {
                switchCameraMode();
              }),
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Offstage(
                  offstage: Global.isCurrentPhotoMode,
                  child: timerWidget,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Visibility(
                      visible: Global.isPhotoing,
                      child: RotationTransition(
                        alignment: Alignment.center,
                        turns: animation,
                        child: Image.asset(
                          "assets/images/ic_cam_dynamic_bg.png",
                          width: 36.0,
                          height: 36.0,
                        ),
                      ),
                    ),
                    SimpleImageButton(
                      width: 36.0,
                      normalImage: Global.isCurrentPhotoMode
                          ? "assets/images/ic_cam_dir_takephoto1.png"
                          : Global.isVideoing
                              ? "assets/images/ic_cam_dir_takevideo2.png"
                              : "assets/images/ic_cam_dir_takevideo1.png",
                      pressedImage: Global.isCurrentPhotoMode
                          ? "assets/images/ic_cam_dir_takephoto2.png"
                          : "assets/images/ic_cam_dir_takevideo2.png",
                      onPressed: () {
                        stratTakePhotoOrVideo();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SimpleImageButton(
            width: 36.0,
            normalImage: "assets/images/ic_cam_dir_setting.png",
            pressedImage: "assets/images/ic_cam_dir_setting.png",
            onPressed: () {
//              showToast("setting");
              if (showCameraSettingWidget) {
                showCameraSettingWidget = false;
//                dismissCameraSettingDialog(context);
              } else {
                showCameraSettingWidget = true;
//                showCameraSettingDialog(context);
    }
    context.read<CameraSettingStatus>().setShowCameraSetting(showCameraSettingWidget);
            },
          ),
        ],
      ),
    );
  }

  TimerWidget timerWidget = TimerWidget();

  switchCameraMode() {
//    Log.logI("切换相机模式");
    if (Global.isVideoing) {
      return;
    }
    setState(() {
      if (Global.isCurrentPhotoMode) {
        Global.isCurrentPhotoMode = false;
      } else {
        Global.isCurrentPhotoMode = true;
      }
    });
  }

  void stratTakePhotoOrVideo() {
//    showToast(isCurrentPhotoMode ? "take phote" : "video");
//    controller.reset();
    setState(() {
      if (Global.isCurrentPhotoMode) {
        if (Global.isPhotoing) {
          Log.logI("stop take photo");
          showToast("stop take photo");
          Global.isPhotoing = false;
          stopTakePhotoAnimation();
        } else {
          Log.logI("start take photo");
          showToast("start take photo");
          Global.isPhotoing = true;
          controller.reset();
          controller.forward();
          timer = Timer(Duration(milliseconds: 5000), () {
            Log.logI("delayed -----  take photo complete ");
            stopTakePhotoAnimation();
            showToast("take photo complete");
          });
        }
      } else {
        if (Global.isVideoing) {
          Log.logI("stop video");
          showToast("stop video");
          Global.isVideoing = false;
          setState(() {
            timerWidget.stopVideo();
          });
        } else {
          Log.logI("start video");
          showToast("start video");
          Global.isVideoing = true;
          setState(() {
            timerWidget.startVideo();
          });
        }
      }
    });
  }

  Timer timer;

  void stopTakePhotoAnimation() {
    timer.cancel();
    controller.stop();
    setState(() {
      Global.isPhotoing = false;
    });
  }

  void initAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      } else if (status == AnimationStatus.dismissed) {
      } else if (status == AnimationStatus.forward) {
      } else if (status == AnimationStatus.reverse) {}
    });
//    controller.forward();
  }

  void dismissCameraSettingDialog(BuildContext context) {
    CameraSettingDialog.dismiss(context);
//    eventBus.fire(ShowCameraSettingEvent(false));
  }

  void showCameraSettingDialog(BuildContext context){
    CameraSettingDialog.show(context);
//    eventBus.fire(ShowCameraSettingEvent(true));
  }
}

