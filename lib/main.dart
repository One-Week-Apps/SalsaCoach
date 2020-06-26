import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:salsa_memo/src/app/pages/onboarding/onboarding_view.dart';

void main() => runApp(MyApp());

const PrimaryColor = const Color(0xFFFFFFFF);

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
          primaryColor: PrimaryColor,
          primarySwatch: Colors.red,
          fontFamily: 'Montserrat'),
      home: OnboardingRoute(),//HomePage(title: 'Salsa Memo 💃'),
      debugShowCheckedModeBanner: false,
    );
  }
}
