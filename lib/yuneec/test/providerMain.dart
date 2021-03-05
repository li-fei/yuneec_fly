// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fly/yuneec/utils/providers/Providers.dart';
import 'package:provider/provider.dart';

import 'TwoWidget.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

//void main() {
//  runApp(
//    /// Providers are above [MyApp] instead of inside it, so that tests
//    /// can use [MyApp] while mocking the providers
//    MultiProvider(
//      providers: [
//        ChangeNotifierProvider(create: (_) => Counter()),
//      ],
//      child: MyApp(),
//    ),
//  );
//}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool

class ProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => MapWidgetStatus()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),

            /// Extracted as a separate widget for performance optimization.
            /// As a separate widget, it will rebuild independently from [MyHomePage].
            ///
            /// This is totally optional (and rarely needed).
            /// Similarly, we could also use [Consumer] or [Selector].
            const Count(),

            TwoWidget(),

            RaisedButton(
              child: Text("",
//                context.watch<MapWidgetStatus>().isMapFullScreen ? "全屏" : "左下角",
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              onPressed: () {
//                if(context.watch<MapWidgetStatus>().isMapFullScreen){
//                  context.read<MapWidgetStatus>().setMapFullScreen(false);
//                }else{
//                  context.read<MapWidgetStatus>().setMapFullScreen(true);
//                }
                context.read<MapWidgetStatus>().setMapFullScreen(true);
//                context.read<MapWidgetStatus>().setMapFullScreen(!(context.watch<MapWidgetStatus>().isMapFullScreen));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () => context.read<Counter>().setTitle("123"),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

        /// Calls `context.watch` to make [MyHomePage] rebuild when [Counter] changes.
        '${context.watch<Counter>().title}',
        style: Theme.of(context).textTheme.headline4);
  }
}
