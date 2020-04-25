import 'package:salsa_memo/src/domain/entities/move.dart';

import './home_presenter.dart';
import '../../../domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeController extends Controller {
  int _counter;
  User _user;
  List<Move> _moves;
  
  // data used by the View
  int get counter => _counter;
  User get user => _user;
  List<Move> get moves => _moves;
  
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
  }

  void getUser() => homePresenter.getUser('test-uid');
  void getUserwithError() => homePresenter.getUser('test-uid231243');

  void getAllMoves() => homePresenter.getAllMoves();

  void buttonPressed() {
    _counter++;
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
}
