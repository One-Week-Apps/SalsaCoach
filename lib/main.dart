import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import './src/app/pages/home/home_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Salsa Memo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Montserrat'
      ),
      home: HomePage(title: 'Salsa Memo 💃'),
      debugShowCheckedModeBanner: false,
    );
  }
}
