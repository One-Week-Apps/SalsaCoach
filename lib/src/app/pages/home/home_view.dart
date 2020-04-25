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
    new Tab(text: 'Account', icon: new Icon(Icons.account_circle)),
  ];

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
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        onPressed: () => controller.buttonPressed(),
        tooltip: 'Add Salsa Move',
        child: Icon(Icons.add),
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

    var table = Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget> [
        for(var item in controller.moves ) _moveTableViewCell(item)
      ]);

    return table;
  }

  Widget _statsTab() {
    return Text('2');
  }

  Widget _accountView() {
    return Text('3');
  }

  @override
  Widget buildPage() {
    return DefaultTabController(
      length: _tabs.length, 
      child: Scaffold(
        appBar: _appBar(),
        bottomNavigationBar: _menu(),
        body: TabBarView(
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
