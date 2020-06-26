import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salsa_memo/src/app/CustomImages.dart';
import 'package:salsa_memo/src/app/pages/achievements/achievements_controller.dart';
import 'package:salsa_memo/src/domain/entities/achievement.dart';
import 'package:salsa_memo/src/domain/usecases/achievements_usecase.dart';

import '../stats/stats_view.dart';

class AchievementsRoute extends View {
  AchievementsRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AchievementsRouteState createState() => _AchievementsRouteState();
}

class _AchievementsRouteState
    extends ViewState<AchievementsRoute, AchievementsController>
    with SingleTickerProviderStateMixin {
  _AchievementsRouteState() : super(AchievementsController());

  Widget _cell(int index, Achievement achievement) {
    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(CustomImages.achievementViewOuter),
        Padding(
            padding: EdgeInsets.only(top: 15),
            child: Image.asset(CustomImages.achievementBackground)),
        Text(
          achievement.name,
          textAlign: TextAlign.center,
          style: GoogleFonts.salsa(fontSize: 15),
        ),
        Padding(
            padding: EdgeInsets.only(top: 35),
            child: Image.asset(
              achievement.currentStep == achievement.numberOfStep
                  ? CustomImages.unlocked
                  : CustomImages.locked,
              width: 26,
              height: 34,
            )),
      ],
    );

    int points = 250 + 250 * (int.tryParse(achievement.uid) % 10);

    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          stack,
          Container(
            width: 48.0,
            height: 6.0,
            color: Colors.transparent,
          ),
          Text(
              "${achievement.currentStep}/${achievement.numberOfStep} Completed"),
          Container(
            width: 48.0,
            height: 3.0,
            color: Colors.grey,
          ),
          Container(
            width: 48.0,
            height: 6.0,
            color: Colors.transparent,
          ),
          Text("$points PTS"),
          Container(
            width: 48.0,
            height: 6.0,
            color: Colors.transparent,
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.orange,
            onPressed: (achievement.currentStep != achievement.numberOfStep ||
                    achievement.isRewardClaimed)
                ? null
                : () {
                    controller.executeAchievements(
                        AchievementsRequestType.doClaim, achievement.uid);
                  },
            child: Text(
              'Claim',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ]));
  }

  @override
  Widget buildPage() {
    controller.executeAchievements(AchievementsRequestType.doFetch, null);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trophies',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(CustomImages.stats),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatsRoute()),
              );
            },
          )
        ],
      ),
      body: Center(
          child: GridView.count(
        childAspectRatio: 1 / 1.5,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          for (var i = 0; i < controller.achievements.length; i++)
            _cell(i, controller.achievements[i])
        ],
      )),
    );
  }
}
