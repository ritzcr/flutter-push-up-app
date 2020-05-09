import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 追加
import 'package:proximity_plugin/proximity_plugin.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale("ja", "JP")],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Push Up Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String currentState = "No";

  String _proximity;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    _streamSubscriptions.add(proximityEvents.listen((ProximityEvent event) {
      setState(() {
        _proximity = event.x;
        if (_proximity != currentState) {
          currentState = _proximity;
          if (currentState == "Yes") {
            _counter++;
          }
        } else {}
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Current',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ));
  }
}
