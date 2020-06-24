import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salsa_memo/src/app/CustomImages.dart';
import 'package:salsa_memo/src/app/widgets/simple_bar_chart.dart';
import 'package:salsa_memo/src/data/repositories/data_moves_repository.dart';
import 'package:salsa_memo/src/domain/entities/move.dart';

import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../data/repositories/data_users_repository.dart';

import 'package:url_launcher/url_launcher.dart';

import 'stats_view.dart';

class AchievementsRoute extends StatelessWidget {

  Widget _cell() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Stack(alignment: Alignment.center, children: <Widget>[Image.asset(CustomImages.achievementViewOuter), Padding(padding: EdgeInsets.only(top: 15), child: Image.asset(CustomImages.achievementBackground)), Text("Salsero \nMaster !", textAlign: TextAlign.center, style: GoogleFonts.salsa(fontSize: 15),), Padding(padding: EdgeInsets.only(top: 35), child: Image.asset(CustomImages.locked, width: 26, height: 34,))],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD8D8D8),
      appBar: AppBar(
        title: Text(
          'Achievements',
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
        child: 
        GridView.count(
  primary: false,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 2,
  children: <Widget>[
    _cell(),
    _cell(),
    _cell(),
    _cell(),
    _cell(),
    _cell(),
    _cell(),
    _cell(),
    _cell(),
    _cell(),
  ],)
        // RaisedButton(
        //   child: Text('Open route'),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
    );
  }
}