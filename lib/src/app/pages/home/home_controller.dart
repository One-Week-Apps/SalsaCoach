//import 'dart:collection';

import 'package:salsa_memo/src/app/CustomImages.dart';
import 'package:salsa_memo/src/domain/entities/move.dart';
import 'package:salsa_memo/src/domain/entities/performance_score.dart';

import './home_presenter.dart';
import '../../../domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

enum ScoreTypes {
  tempo,
  bodyMovement,
  tracing,
  hairBrushes,
  blocks,
  locks,
  handToss
}

extension ScoreTypesExtension on ScoreTypes {
  static const _names = {
    ScoreTypes.tempo: 'Tempo',
    ScoreTypes.bodyMovement: 'Body Movement',
    ScoreTypes.tracing: 'Tracing',
    ScoreTypes.hairBrushes: 'Hair Brushes',
    ScoreTypes.blocks: 'Blocks',
    ScoreTypes.locks: 'Locks',
    ScoreTypes.handToss: 'Hand Toss',
  };

  String get rawValue => _names[this];
}

class HomeController extends Controller {
  int _counter;
  User _user;
  List<Move> _moves;
  List<Performance> _performances;
  
  // data used by the View
  int get counter => _counter;
  User get user => _user;
  List<Move> get moves => _moves;
  List<Performance> get performances => _performances;
  
  final HomePresenter homePresenter;
  // Presenter should always be initialized this way
  HomeController(usersRepo, movesRepo)
      : _counter = 0,
        homePresenter = HomePresenter(usersRepo, movesRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    homePresenter.getUserOnNext = (User user) {
      print(user.toString());
      _user = user;
      refreshUI(); // Refreshes the UI manually
    };
    homePresenter.getUserOnComplete = () {
      print('User retrieved');
    };

    // On error, show a snackbar, remove the user, and refresh the UI
    homePresenter.getUserOnError = (e) {
      print('Could not retrieve user.');
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      _user = null;
      refreshUI(); // Refreshes the UI manually
    };

    homePresenter.getAllMovesOnNext = (List<Move> moves) {
      print(moves.toString());
      _moves = moves;
      refreshUI();
    };

    homePresenter.addPerformanceOnNext = () {
      print('Performance added!');
    };

    homePresenter.getPerformancesOnNext = (List<Performance> perfs) {
      print(perfs.toString());
      _performances = perfs;
      refreshUI();
    };
  }

  void getUser() => homePresenter.getUser('test-uid');
  void getUserwithError() => homePresenter.getUser('test-uid231243');

  void getAllMoves() => homePresenter.getAllMoves();
  void getAllPerformances() => homePresenter.getAllPerformances();

  void flushMovesButtonPressed() {
    print("flushMovesButtonPressed");
    homePresenter.getAllMoves();
    //refreshUI();
  }

  void ratePerformanceButtonPressed(BuildContext context) {
    print("ratePerformanceButtonPressed");
    showRatingDialog(context);
  }

  void ratePerformanceValidated() {
    print("ratePerformanceValidated");
    var perfScore = PerformanceScore(
      _ratings[ScoreTypes.tempo],
      _ratings[ScoreTypes.bodyMovement],
      _ratings[ScoreTypes.tracing],
      _ratings[ScoreTypes.hairBrushes],
      _ratings[ScoreTypes.blocks],
      _ratings[ScoreTypes.locks],
      _ratings[ScoreTypes.handToss],
    );
    var perf = Performance(DateTime.now().millisecondsSinceEpoch, perfScore, DateTime.now());
    homePresenter.addPerformance(perf);
    refreshUI();
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }

  static var _ratingsKeys = ScoreTypes.values;
  static var _ratingsValues = List.filled(ScoreTypes.values.length, 3);
  Map<ScoreTypes, int> _ratings = new Map.fromIterables(_ratingsKeys, _ratingsValues);

  List<Widget> _starRatingView(ScoreTypes scoreType, StateSetter setState) {
    var children = <Widget>[
      for (var i = 0 ; i < 5 ; i++) new Container(
        width: 40,
        height: 40,
        child: IconButton(icon: new Image.asset(
            i < this._ratings[scoreType] ? CustomImages.starOn : CustomImages.starOff,
            fit: BoxFit.scaleDown,
          ), onPressed: () {
            print("${scoreType.rawValue} rated ${i + 1}");
            setState(() {
              this._ratings[scoreType] = (i + 1);
            });
          })
      )
    ];
    return children;
  }

  Widget _ratingBox(ScoreTypes scoreType) {
    String title = scoreType.rawValue;
    return Column(children: <Widget>[
      Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      StatefulBuilder(builder: (context, setState) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: _starRatingView(scoreType, setState));
      }),
      //Row(mainAxisAlignment: MainAxisAlignment.center, children: _starRatingView(scoreType)),
    ]);
  }

  void showRatingDialog(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Dialog dialogWithImage = Dialog(
      child: Container(
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.9,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 30),
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Text(
                "Performance Self-Rating",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),

            // Rating Box
            Text("Rate your dance style \nto track your progress \nand earn achievements !", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Spacer(flex: 2),
            _ratingBox(ScoreTypes.tempo),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.bodyMovement),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.tracing),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.hairBrushes),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.blocks),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.locks),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.handToss),
            Spacer(flex: 2),

            // Confirm Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    this.ratePerformanceValidated();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                )
              ],
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
}
}
