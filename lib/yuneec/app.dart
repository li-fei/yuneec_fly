import 'package:flutter/material.dart';
import 'package:fly/yuneec/test/TestMain.dart';
import 'package:fly/yuneec/test/debug/debugProviders.dart';
import 'package:fly/yuneec/test/providerMain.dart';
import 'package:fly/yuneec/utils/providers/cameraProviders.dart';
import 'file:///F:/ASworkspace/yuneec_fly/lib/yuneec/utils/providers/Providers.dart';
import 'package:provider/provider.dart';

//import 'test/AnimatedWidget.dart';

import 'mainWidget.dart';
import 'utils/providers/settingsProviders.dart';

//import 'test/ProvideMainWidget.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  MainWeight mainWidget = MainWeight();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: Text("app"),
//      ),
      body: Container(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DebugStatus()),
            ChangeNotifierProvider(create: (_) => MapWidgetStatus()),
            ChangeNotifierProvider(create: (_) => CommonSettingStatus()),
            ChangeNotifierProvider(create: (_) => CameraSettingStatus()),
            ChangeNotifierProvider(create: (_) => StateBarStatus()),
          ],
          child: mainWidget,
//      child: TestMain(),
        ),
      ),
    );
  }
}
