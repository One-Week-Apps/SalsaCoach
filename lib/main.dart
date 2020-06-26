import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:salsa_memo/src/app/pages/achievements/achievements_controller.dart';
import 'package:salsa_memo/src/app/pages/moves_details/moves_details_view.dart';
import 'package:salsa_memo/src/app/pages/moves_listing/moves_listing_view.dart';
import 'package:salsa_memo/src/app/pages/onboarding/onboarding_view.dart';
import 'package:salsa_memo/src/app/pages/stats/stats_view.dart';
import 'package:salsa_memo/src/domain/entities/achievement.dart';
import 'package:salsa_memo/src/domain/entities/move.dart';
import 'package:salsa_memo/src/domain/usecases/achievements_observer.dart';

void main() => runApp(MyApp());

const PrimaryColor = const Color(0xFFFFFFFF);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    AchievementsObserver achievementsObserver = AchievementsController();

    return MaterialApp(
      title: 'Salsa Memo',
      theme: ThemeData(
          primaryColor: PrimaryColor,
          primarySwatch: Colors.red,
          fontFamily: 'Montserrat'),
      home: OnboardingRoute(),//HomePage(title: 'Salsa Memo 💃'),
      routes: {
        MovesListingRoute.routeName: (context) => MovesListingRoute(achievementsObserver),
        MovesDetailsRoute.routeName: (context) { 
          final Move move = ModalRoute.of(context).settings.arguments; 
          return MovesDetailsRoute(achievementsObserver, move); 
        },
        StatsRoute.routeName: (context) => StatsRoute(achievementsObserver),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
