import 'package:salsa_memo/src/app/CustomImages.dart';
import 'package:salsa_memo/src/app/widgets/simple_bar_chart.dart';
import 'package:salsa_memo/src/data/repositories/data_moves_repository.dart';
import 'package:salsa_memo/src/domain/entities/move.dart';

import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../../../data/repositories/data_users_repository.dart';

class HomePage extends View {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() =>
      // inject dependencies inwards
      _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> with SingleTickerProviderStateMixin {
  _HomePageState() : super(HomeController(DataUsersRepository(), DataMovesRepository()));

  var _tabs = [
    new Tab(text: 'Perform', icon: new Icon(Icons.music_note)),
    new Tab(text: 'Stats', icon: new Icon(Icons.insert_chart)),
    new Tab(text: 'Settings', icon: new Icon(Icons.settings)),
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
        onPressed: () => controller.ratePerformanceButtonPressed(),
        tooltip: 'Rate Performance',
        child: Icon(Icons.check),
      );
  }

  var _doOnce = true;

  Widget _moveTableViewCell(Move item) {
    return Container(height: 100.0, child: Text(item.name + ': ' + item.description + ' - ' + item.urlString));
  }

  Widget _performTab() {

    if (_doOnce) {
      _doOnce = false;
      controller.getAllMoves();
    }

    var children = <Widget> [
        for(var item in controller.moves ) _moveTableViewCell(item)
    ];

    var table = Column(mainAxisAlignment: MainAxisAlignment.center, children: children);
    return table;
  }

  Widget _achievementsCell(String text, bool isComplete) {
    return Row(children: <Widget> [
      new Image.asset(CustomImages.logo, width: 50,),
      Text(text),
      Spacer(flex: 1,),
      new Image.asset(isComplete ? CustomImages.starOn : CustomImages.starOff, width: 50,),
    ]);
  }

  Widget _statsTab() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Column(children: <Widget>[
        Text("Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),),
        SizedBox(height: 10,),
        Container(child: SimpleBarChart.withSampleData(), height: MediaQuery.of(context).size.height / 3,),
        SizedBox(height: 50,),
        Text("Achievements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),),
        SizedBox(height: 10,),
        Column(children: <Widget>[
          _achievementsCell("Perform a first dance", true),
          _achievementsCell("Perform 3 consecutive days", false),
          _achievementsCell("Perform 5 consecutive days", true),
          _achievementsCell("Perform 5 consecutive days", true),
          _achievementsCell("Perform 5 consecutive days", true),
          _achievementsCell("Perform 5 consecutive days", true),
          _achievementsCell("Perform 5 consecutive days", true),
          _achievementsCell("Perform 5 consecutive days", true),
          _achievementsCell("Perform 5 consecutive days", true),
        ],)
      ],),
    );
  }

  Widget _accountView() {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 16.0),
      child: new InkWell(
        child: new Card(
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new ListTile(
                  leading: new Image.asset(CustomImages.logo, fit: BoxFit.contain,),
                  title: new Text("Sombrero"),),

              ),
              new Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.blue,child: new Text("3",style: new TextStyle(color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _floatingActionButtons() {
    if (_selectedTabIndex == 0) {
      return Row(children: <Widget>[
          Spacer(flex: 14,),
          _refreshMovesButton(),
          Spacer(flex: 1,),
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
            _accountView(),
        ],),
      ),
    );

  }

}
      
      // body: Scaffold(
      //   key:
      //       globalKey, // built in global key for the ViewState for easy access in the controller
      //   body: 
        
      //   // Center(
      //   //   child: Column(
      //   //     mainAxisAlignment: MainAxisAlignment.center,
      //   //     children: <Widget>[
      //   //       Text(
      //   //         // use data provided by the controller
      //   //         'Button pressed ${controller.counter} times.',
      //   //       ),
      //   //       Text(
      //   //         'The current user is',
      //   //       ),
      //   //       Text(
      //   //         controller.user == null ? '' : '${controller.user}',
      //   //         style: Theme.of(context).textTheme.display1,
      //   //       ),
      //   //       RaisedButton(
      //   //         onPressed: controller.getUser,
      //   //         child: Text(
      //   //           'Get User',
      //   //           style: TextStyle(
      //   //             fontFamily: CustomFonts.montserratBlack, 
      //   //             color: Colors.white
      //   //             ),
      //   //         ),
      //   //         color: Colors.blue,
      //   //       ),
      //   //       RaisedButton(
      //   //         onPressed: controller.getUserwithError,
      //   //         child: Text(
      //   //           'Get User Error',
      //   //           style: TextStyle(color: Colors.white),
      //   //         ),
      //   //         color: Colors.blue,
      //   //       )
      //   //     ],
      //   //   ),
      //   // ),



      // ),
