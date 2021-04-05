import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:oktoast/oktoast.dart';
import 'package:salsa_coach/src/app/SharedPreferencesKeys.dart';
import 'package:salsa_coach/src/app/pages/achievements/achievements_controller.dart';
import 'package:salsa_coach/src/app/pages/moves_details/moves_details_view.dart';
import 'package:salsa_coach/src/app/pages/moves_listing/moves_listing_view.dart';
import 'package:salsa_coach/src/app/pages/onboarding/onboarding_view.dart';
import 'package:salsa_coach/src/app/pages/stats/stats_view.dart';
import 'package:salsa_coach/src/data/repositories/in_memory_performance_repository.dart';
import 'package:salsa_coach/src/domain/entities/move.dart';
import 'package:salsa_coach/src/domain/usecases/achievements_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var _sharedPref = SharedPref();
  bool tutorialCompleted;
  try {
    tutorialCompleted = await _sharedPref.read(SharedPreferencesKeys.tutorialCompleted);
  } catch (e) {
    tutorialCompleted = false;
  }
  runApp(MyApp(tutorialCompleted));
}

const PrimaryColor = const Color(0xFFFFFFFF);

class MyApp extends StatelessWidget {
  MyApp(this.tutorialCompleted);
  final bool tutorialCompleted;

  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    AchievementsObserver achievementsObserver = AchievementsController();
    var homeRoute = tutorialCompleted ? MovesListingRoute(achievementsObserver) : OnboardingRoute();

    return OKToast(
          child: MaterialApp(
        title: 'Salsa Coach',
        theme: ThemeData(
            primaryColor: PrimaryColor,
            primarySwatch: Colors.red,
            fontFamily: 'Montserrat'),
        home: homeRoute,//HomePage(title: 'Salsa Coach 💃'),
        routes: {
          MovesListingRoute.routeName: (context) => MovesListingRoute(achievementsObserver),
          MovesDetailsRoute.routeName: (context) { 
            final Move move = ModalRoute.of(context).settings.arguments; 
            return MovesDetailsRoute(achievementsObserver, move); 
          },
          StatsRoute.routeName: (context) => StatsRoute(achievementsObserver),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
