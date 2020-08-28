import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class YuneecPlayer extends StatefulWidget {
  @override
  YuneecPlayerState createState() => new YuneecPlayerState();
}

class YuneecPlayerState extends State<YuneecPlayer> {
  IjkMediaController controller = IjkMediaController();

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildIjkPlayer();
  }

  Widget buildIjkPlayer() {
    return Container(
      child: IjkPlayer(
        mediaController: controller,
      ),
    );
  }

  //'https://www.runoob.com/try/demo_source/mov_bbb.mp4'
  String url = "rtsp://192.168.42.1:554/live";
  Future<void> initVideo() async {
    print("initVideo()");
    await controller.setNetworkDataSource(url, autoPlay: true);
  }
}
