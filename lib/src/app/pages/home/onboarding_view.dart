import 'package:flutter/cupertino.dart';
import 'package:salsa_memo/main.dart';
import 'package:salsa_memo/src/app/CustomFonts.dart';
import 'package:salsa_memo/src/app/CustomImages.dart';
import 'package:salsa_memo/src/app/pages/home/home_view.dart';
import 'package:salsa_memo/src/app/widgets/simple_bar_chart.dart';
import 'package:salsa_memo/src/data/repositories/data_moves_repository.dart';
import 'package:salsa_memo/src/domain/entities/move.dart';

import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../data/repositories/data_users_repository.dart';

import 'package:url_launcher/url_launcher.dart';

import 'moves_listing_view.dart';

import 'package:lottie/lottie.dart';

import 'package:google_fonts/google_fonts.dart';



class OnboardingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goToNextAnimationView = Lottie.asset('assets/animations/Onboarding_Slide_Left_Arrows_Animation.json');
    var style = GoogleFonts.salsa(fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salsa Memo',
        style: GoogleFonts.salsa(fontSize: 30)),
        // style: TextStyle(
        //   fontFamily: CustomFonts.salsaRegular,
        //   color: Colors.white
        // ),),
      ),
      body: Center(
        child:
          PageView(
            children: <Widget>[

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Try to perform these moves \nin one dance !', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingMoves, height: 300,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Then self-rate your dance style \nusing the validation button below.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingDone, height: 50,),
                Image.asset(CustomImages.onboardingRating, height: 250,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Followers can still rate their dancing \neven if not performing these moves.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.logo, height: 250,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Access more details \nby selecting a particular move.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingMoveDetails, height: 250,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Track your progress by \nearning various achievements.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingAchievements, height: 250,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Access to your stats to see \nyour progress for the current week.', textAlign: TextAlign.center, style: style,),
                Image.asset(CustomImages.stats, height: 50,),
                Spacer(flex: 1),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Well done, you have \ncompleted this tutorial!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                RaisedButton(
                  child: Text('Lets go!'),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MovesListingRoute()),
                    );
                  },
                ),
                Spacer(flex: 1),
              ]),


            ],
          )
          ),

          
        //Text('Try to perform those moves in one dance !Then rate your dance style using the validate button below. Followers can still rate their dance style even if not performing these moves.', textAlign: TextAlign.center,),
        //Text("Animation here..."),
    );
  }
}