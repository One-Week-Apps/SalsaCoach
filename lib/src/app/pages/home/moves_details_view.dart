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

class MovesDetailsRoute extends StatelessWidget {
  final Move move;
  MovesDetailsRoute(this.move);

  @override
  Widget build(BuildContext context) {
    print("MOVE = " + move.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Move Details',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
      ),
      body: Column(children: <Widget>[Container(
        // alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.only(top: 40),
                  width: MediaQuery.of(context).size.width,
                  //height: 377,
                  color: Colors.white,
                  child: Column(
                    children: 
                    <Widget>[
                      // InkWell(child: Stack(alignment: Alignment.center, children: [
                      //   Image.asset(CustomImages.placeholder1),
                      //   Image.asset(CustomImages.play),
                      // ]), onTap: () => launch("https://www.youtube.com/embed/AqnNTeRs2Pw")),
                      
                      Padding(padding: EdgeInsets.only(left: 10, right: 10), child: 
                      Column(children: <Widget>[
Row(
                        children: <Widget>[
                          Text(move.name,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                          Spacer(
                            flex: 1,
                          ),
                          Image.asset(
                            CustomImages.like,
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Difficulty: ${move.difficulty} over 5",
                            textAlign: TextAlign.left,
                          )),
                      Text(" "),
                      Text(
                          move.description
                      ),
                      ])
                        
                      )
                    ],
                  ),
                ),
              ), Spacer(flex: 10,), Container(
                alignment: Alignment.bottomCenter, 
                child: InkWell(child: InkWell(child: Stack(alignment: Alignment.center, children: [
                        Image.asset(CustomImages.placeholder1),
                        Image.asset(CustomImages.play),
                      ]), onTap: () => launch(move.urlString)),),
              ), Spacer(flex: 1,),]),
    );
  }
}