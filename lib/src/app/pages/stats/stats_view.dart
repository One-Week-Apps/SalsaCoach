import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salsa_memo/src/app/widgets/simple_bar_chart.dart';
import 'package:salsa_memo/src/data/repositories/data_moves_repository.dart';

import '../../../data/repositories/data_users_repository.dart';
import '../home/home_controller.dart';

class StatsRoute extends View {
  StatsRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StatsRouteState createState() => _StatsRouteState();
}

class _StatsRouteState extends ViewState<StatsRoute, HomeController>
    with SingleTickerProviderStateMixin {
  _StatsRouteState()
      : super(HomeController(DataUsersRepository(), DataMovesRepository()));

  Widget _statsTab() {
    controller.getAllPerformances();
    // setState(() {});

    var children = <Widget>[
      Text(
        "Progress",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        child: SimpleBarChart.withPerformances(controller.performances ?? []),
        height: MediaQuery.of(context).size.height / 3.5,
      ),
      SizedBox(
        height: 50,
      ),
      Text(
        "Progress",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        child: SimpleBarChart.withPerformances(controller.performances ?? []),
        height: MediaQuery.of(context).size.height / 3.5,
      ),
      SizedBox(
        height: 50,
      ),
    ];

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ListView(
          children: children,
        )

        // Column(
        //   children: children,
        // ),
        );
  }

  @override
  Widget buildPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stats',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
      ),
      body: Center(child: _statsTab()),
    );
  }
}
