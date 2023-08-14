import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as fcl;
import 'package:google_fonts/google_fonts.dart';
import 'package:salsa_coach/src/app/custom_images.dart';
import 'package:salsa_coach/src/app/pages/moves_details/moves_details_view.dart';
import 'package:salsa_coach/src/data/repositories/data_moves_repository.dart';
import 'package:salsa_coach/src/domain/entities/achievement_types.dart';
import 'package:salsa_coach/src/domain/entities/move.dart';
import 'package:salsa_coach/src/domain/usecases/achievements_observer.dart';

import '../achievements/achievements_view.dart';
import 'moves_listing_controller.dart';

class MovesListingRoute extends fcl.View {
  static const routeName = '/movesListing';
  final AchievementsObserver achievementsObserver;
  MovesListingRoute(this.achievementsObserver, {Key? key}) : super(key: key);

  @override
  _MovesListingRouteState createState() {
    final controller = MovesListingController(DataMovesRepository());
    return _MovesListingRouteState(controller);
  }
}

class _MovesListingRouteState extends fcl.ViewState<MovesListingRoute, MovesListingController> {

    MovesListingController controller;

    _MovesListingRouteState(MovesListingController controller)
      : this.controller = controller, super(controller);

  Widget _refreshMovesButton() {
    return FloatingActionButton(
      heroTag: "refreshMovesButton",
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      onPressed: () {
        this.widget.achievementsObserver.update(AchievementTypes.refresher);
        controller.flushMovesButtonPressed();
      },
      tooltip: 'Flush Salsa Moves',
      child: Icon(Icons.refresh),
    );
  }

  Widget _moveTableViewCell(int index, Move item) {
    var move = controller.moves[index];
    print("move[${index.toString()}] = $move");
    var thumbnailWidth = MediaQuery.of(context).size.width - 100;
    var thumbnail = Image.network(move.thumbnailUrlString, width: thumbnailWidth, height: thumbnailWidth * 360 / 480);

    return InkWell(
                child: Container(
                  width: 356,
                  height: 500,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      thumbnail,
                      Row(
                        children: <Widget>[
                          Text('\n' + move.name,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                          Spacer(
                            flex: 1,
                          ),
                          Image.asset(
                  move.isLiked ? CustomImages.like : CustomImages.dislike,
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
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          move.description, maxLines: 2,))
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    MovesDetailsRoute.routeName,
                    arguments: move
                  );
                },
              );
  }

  Widget _ratePerformanceButton() {
    return FloatingActionButton(
      heroTag: "ratePerformanceButton",
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      onPressed: () {
        controller.ratePerformanceButtonPressed(context);
      },
      tooltip: 'Flush Salsa Moves',
      child: Icon(Icons.done),
    );
  }

  var _doOnce = true;
  @override
  Widget get view => buildPage();

  Widget buildPage() {

    if (_doOnce) {
      _doOnce = false;
      controller.getAllMoves();
    }

    return Scaffold(
      key: globalKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Container(width: 200, padding: EdgeInsets.only(top: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[_refreshMovesButton(), SizedBox(width: 5), _ratePerformanceButton()]),
      ),
      appBar: AppBar(
        title: Text(
          'Salsa Coach',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(CustomImages.trophy),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsRoute()),
              );
            },
          )
        ],
      ),
      body: Center(
        child:
            fcl.ControlledWidgetBuilder<MovesListingController>(builder: ((BuildContext context, MovesListingController controller) {
              var children = <Widget>[
                for (var i = 0 ; i < controller.moves.length ; i++) _moveTableViewCell(i, controller.moves[i])
              ];
              return ListView(
                padding: const EdgeInsets.all(8)
                    .add(EdgeInsets.only(top: 100))
                    .add(EdgeInsets.only(bottom: 50)),
                children: children,
      );
  }))),
    );
  }

}
