import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fly/yuneec/app.dart';
import 'package:fly/yuneec/loading.dart';

import 'locale/translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MaterialApp(
    localizationsDelegates: [
      const TranslationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''),
      const Locale('zh', ''),
    ],
    debugShowCheckedModeBanner: false,
    title: 'Yuneec Fly',
    theme: mDefaultTheme,
    routes: routes,
    home: LoadingPage(),
  ));
  await enableFluttifyLog(false);
  await AmapService.init(
    iosKey: '7a04506d15fdb7585707f7091d715ef4',
    androidKey: '9cd927a76fd9c2b0bd1129e5d8d8a73e',
  );
}

final routes = {
  "app": (BuildContext context) => App(),
};

final ThemeData mDefaultTheme = new ThemeData(
  primaryColor: Color(0xff303030),
  scaffoldBackgroundColor: Color(0xFFebebeb),
  cardColor: Color(0xff393a3f),
);
