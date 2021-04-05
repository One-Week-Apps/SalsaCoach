import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:salsa_coach/src/app/CustomImages.dart';
import 'package:salsa_coach/src/app/widgets/simple_bar_chart.dart';
import 'package:salsa_coach/src/data/repositories/data_moves_repository.dart';
import 'package:salsa_coach/src/domain/entities/move.dart';
import 'package:url_launcher/url_launcher.dart';

import './home_controller.dart';
import '../../../data/repositories/data_users_repository.dart';

class HomePage extends View {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController>
    with SingleTickerProviderStateMixin {
  _HomePageState()
      : super(HomeController(DataUsersRepository(), DataMovesRepository()));

  var _tabs = [
    new Tab(text: 'Perform', icon: new Icon(Icons.music_note)),
    new Tab(text: 'Stats', icon: new Icon(Icons.insert_chart)),
    // new Tab(text: 'Moves', icon: new Icon(Icons.library_books)),
  ];

  var _selectedTabIndex = 0;

  Widget _appBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  Widget _menu() {
    return Container(
      height: 100.0,
      color: Colors.red,
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(10.0),
        indicatorColor: Colors.white,
        tabs: _tabs,
        onTap: (index) {
          _selectedTabIndex = index;
          controller.getAllPerformances();
          setState(() {});
        },
      ),
    );
  }

  Widget _refreshMovesButton() {
    return FloatingActionButton(
      onPressed: () => controller.flushMovesButtonPressed(),
      tooltip: 'Flush Salsa Moves',
      child: Icon(Icons.refresh),
    );
  }

  Widget _ratePerformanceButton() {
    return FloatingActionButton(
      onPressed: () => controller.ratePerformanceButtonPressed(context),
      tooltip: 'Rate Performance',
      child: Icon(Icons.check),
    );
  }

  var _doOnce = true;

  Widget _moveTableViewCell(int index, Move item) {
    return Row(children: <Widget>[
      new Image.asset(
        CustomImages.logo,
        width: 50,
      ),
      Text(item.name, style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20.0),),
      Spacer(
        flex: 9,
      ),
      for (int i = 0; i < item.difficulty ?? 0; i++)
        new Image.asset(
          CustomImages.fire,
          width: 40,
        ),
      Spacer(
        flex: 1,
      ),
      IconButton(iconSize: 40, icon: Icon(Icons.help_outline), onPressed: () {
        print("Help at index " + index.toString());
        var item = controller.moves[index];
        showCupertinoDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text(item.name),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(item.tempo + "\n"),
                  Text(item.description + "\n"),
                  GestureDetector(child: Text(item.urlString, style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)), onTap: () {
                    launch(item.urlString);
                  },),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
      });
    }),
    ]);
  }

  Widget _performTab() {
    if (_doOnce) {
      _doOnce = false;
      controller.getAllMoves();
    }

    var children = <Widget>[
      for (var i = 0 ; i < controller.moves.length ; i++) _moveTableViewCell(i, controller.moves[i])
      // for (var item in controller.moves) _moveTableViewCell(item)
    ];

    var table = Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: children,
                ).toList(),
              ));

    // var table =
        // Column(mainAxisAlignment: MainAxisAlignment.center, children: children);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text("Moves List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
      Spacer(flex: 1),
      Text("Try to perform those moves \nin one dance ! \n\nThen rate your dance style using the validate button below. \n\nFollowers can still rate \ntheir dance style even if not \nperforming these moves.\n", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      Spacer(flex: 1),
      table,
      Spacer(flex: 1),
    ],);//table;
  }

  Widget _achievementsCell(String text, bool isComplete) {
    return Row(children: <Widget>[
      new Image.asset(
        CustomImages.cup,
        width: 40,
      ),
      Spacer(
        flex: 1,
      ),
      Text(text),
      Spacer(
        flex: 8,
      ),
      new Image.asset(
        isComplete ? CustomImages.starOn : CustomImages.starOff,
        width: 50,
      ),
    ]);
  }

  Widget _statsTab() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Text(
            "Progress",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: SimpleBarChart.withPerformances(StatsType.starsCount, DateTime.now(), controller.performances ?? []),
            height: MediaQuery.of(context).size.height / 3.5,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Achievements",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    for (var i = 0; i < 10; i++)
                      _achievementsCell("Coming soon...", true),
                  ],
                ).toList(),
              )),
        ],
      ),
    );
  }

  Widget _accountView() {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Sun'),
          ),
          ListTile(
            title: Text('Moon'),
          ),
          ListTile(
            title: Text('Star'),
          ),
        ],
      ).toList(),
    );
  }

  Widget _floatingActionButtons() {
    if (_selectedTabIndex == 0) {
      return Row(children: <Widget>[
        Spacer(
          flex: 14,
        ),
        _refreshMovesButton(),
        Spacer(
          flex: 1,
        ),
        _ratePerformanceButton(),
      ]);
    } else {
      return Container();
    }
  }

  @override
  Widget buildPage() {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: _appBar(),
        bottomNavigationBar: _menu(),
        floatingActionButton: _floatingActionButtons(),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            _performTab(),
            _statsTab(),
            // _accountView(),
          ],
        ),
      ),
    );
  }
}
