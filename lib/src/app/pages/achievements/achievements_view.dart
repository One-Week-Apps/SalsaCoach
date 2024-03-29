import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as fcl;
import 'package:google_fonts/google_fonts.dart';
import 'package:salsa_coach/src/app/custom_images.dart';
import 'package:salsa_coach/src/app/pages/achievements/achievements_controller.dart';
import 'package:salsa_coach/src/domain/entities/achievement.dart';
import 'package:salsa_coach/src/domain/usecases/achievements_usecase.dart';

import 'package:oktoast/oktoast.dart';

import '../stats/stats_view.dart';

class AchievementsRoute extends fcl.View {
  AchievementsRoute({Key? key}) : super(key: key);

  @override
  _AchievementsRouteState createState() {
    final controller = AchievementsController();
    return _AchievementsRouteState(controller);
  }
}

class _AchievementsRouteState
    extends fcl.ViewState<AchievementsRoute, AchievementsController>
    with SingleTickerProviderStateMixin {
  AchievementsController controller;
  _AchievementsRouteState(AchievementsController controller) : this.controller = controller, super(controller);

  Widget _cell(int index, Achievement achievement) {
    var stack = GestureDetector(
      onTap: () {
        print("Showing achievement description");
        showInfoDialog(achievement.name, achievement.description);
      }, child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(CustomImages.achievementViewOuter),
        Padding(
            padding: EdgeInsets.only(top: 15),
            child: Image.asset(achievement.isRewardClaimed ? CustomImages.achievementBackgroundUnlocked : CustomImages.achievementBackground)),
        Text(
          achievement.name.replaceFirst(" ", "\n") + "\n\n",
          textAlign: TextAlign.center,
          style: GoogleFonts.salsa(textStyle: TextStyle(fontSize: 15, color: Colors.white)),
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
    ));

    int points = 250 + 250 * (int.tryParse(achievement.uid)! % 10);

    return Tooltip(
          message: achievement.description,
          child: GestureDetector(
            child: Container(
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
                color: (achievement.isRewardClaimed) ? Colors.orange[900] : Colors.grey,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.orange,
                  disabledBackgroundColor: Colors.transparent,
                ),
                onPressed: (achievement.currentStep != achievement.numberOfStep ||
                        achievement.isRewardClaimed)
                    ? null
                    : () {
                        controller.executeAchievements(
                            AchievementsRequestType.doClaim, achievement.uid);
                        showToastWidget(Image.asset(CustomImages.achievementTrophy));
                      },
                child: Text(
                  'Claim',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ])),
      ),
    );
  }

  var doOnce = true;

    showInfoDialog(String title, String text) {
      // set up the buttons
      Widget closeButton = TextButton(
        child: Text("Got it!"),
        onPressed:  () {
          Navigator.pop(context);
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          closeButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    showAlertDialog(BuildContext context, String title, String text, VoidCallback onConfirm) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed:  () {
          Navigator.pop(context);
        },
      );
      Widget continueButton = TextButton(
        child: Text("Confirm"),
        onPressed: () {
          Navigator.pop(context);
          onConfirm();
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
  }

  @override
  Widget get view => buildPage();

  Widget buildPage() {
    if (doOnce) {
      doOnce = false;
      controller.executeAchievements(AchievementsRequestType.doFetch, "");
    }

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
              Navigator.pushNamed(
                context, 
                StatsRoute.routeName
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          fcl.ControlledWidgetBuilder<AchievementsController>(builder: ((BuildContext context, AchievementsController controller) {
          return Expanded(child: Center(
              child: GridView.count(
            childAspectRatio: MediaQuery.of(context).size.height < 800 ? 1 / 1.7 : 1 / 1.3,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              for (var i = 0; i < controller.achievements.length; i++)
                _cell(i, controller.achievements[i])
            ],
          )) );})),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                  shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  showAlertDialog(context, "Reset progress", "This will reset all your progress. \nAre you sure you want to continue?", (){
                    controller.executeAchievements(
                      AchievementsRequestType.doReset, "");
                  });
                },
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
