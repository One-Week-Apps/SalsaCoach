import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salsa_coach/src/app/CustomImages.dart';
import 'package:salsa_coach/src/app/pages/moves_details/moves_details_view.dart';
import 'package:salsa_coach/src/data/repositories/data_moves_repository.dart';
import 'package:salsa_coach/src/domain/entities/achievement_types.dart';
import 'package:salsa_coach/src/domain/entities/move.dart';
import 'package:salsa_coach/src/domain/usecases/achievements_observer.dart';

import '../../../data/repositories/data_users_repository.dart';
import '../achievements/achievements_view.dart';
import '../home/home_controller.dart';

class MovesListingRoute extends View {
  static const routeName = '/movesListing';
  final AchievementsObserver achievementsObserver;
  MovesListingRoute(this.achievementsObserver, {Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MovesListingRouteState createState() => _MovesListingRouteState();
}

class _MovesListingRouteState extends ViewState<MovesListingRoute, HomeController>
    with SingleTickerProviderStateMixin {
    _MovesListingRouteState()
      : super(HomeController(DataUsersRepository(), DataMovesRepository()));

  Widget _refreshMovesButton() {
    return FloatingActionButton(
      heroTag: "refreshMovesButton",
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

    return InkWell(
                child: Container(
                  width: 356,
                  height: 377,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Image.asset(CustomImages.placeholder1),
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
                          move.description.substring(0, min(200, move.description.length - 1)) + "..."))
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
    
    /*Row(children: <Widget>[
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
    ]);*/
  }

  Widget _ratePerformanceButton() {
    return FloatingActionButton(
      heroTag: "ratePerformanceButton",
      backgroundColor: Colors.black,
      onPressed: () {
        controller.ratePerformanceButtonPressed(context);
      },
      tooltip: 'Flush Salsa Moves',
      child: Icon(Icons.done),
    );
  }

  var _doOnce = true;
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

  @override
  Widget buildPage() {
    //var goToNextAnimationView = Lottie.asset('assets/animations/Onboarding_Slide_Left_Arrows_Animation.json');

    if (_doOnce) {
      _doOnce = false;
      controller.getAllMoves();
    }

    var children = <Widget>[
      for (var i = 0 ; i < controller.moves.length ; i++) _moveTableViewCell(i, controller.moves[i])
      // for (var item in controller.moves) _moveTableViewCell(item)
    ];

    return Scaffold(
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
        child: //Column(children: <Widget>[
            ListView(
                padding: const EdgeInsets.all(8)
                    .add(EdgeInsets.only(top: 100))
                    .add(EdgeInsets.only(bottom: 50)),
                children: children,
            //     <Widget>[
            //   //=====================
            //   // new Transform(
            //   //   transform: new Matrix4.rotationZ(math.pi/2).scaled(0.5),
            //   //   alignment: FractionalOffset.center,
            //   //   child: goToNextAnimationView,
            //   // ),

            //   InkWell(
            //     child: Container(
            //       width: 356,
            //       height: 377,
            //       color: Colors.white,
            //       child: Column(
            //         children: <Widget>[
            //           Image.asset(CustomImages.placeholder1),
            //           Row(
            //             children: <Widget>[
            //               Text("El Uno",
            //                   style: GoogleFonts.montserrat(
            //                       fontSize: 20,
            //                       fontWeight: FontWeight.w900)),
            //               Spacer(
            //                 flex: 1,
            //               ),
            //               Image.asset(
            //                 CustomImages.like,
            //                 width: 20,
            //                 height: 20,
            //               )
            //             ],
            //           ),
            //           Container(
            //               alignment: Alignment.centerLeft,
            //               child: Text(
            //                 "Difficulty: 2 over 5",
            //                 textAlign: TextAlign.left,
            //               )),
            //           Text(" "),
            //           Text(
            //               "Start with a right to right hold of the hands, Switch On 7 if coming from Guapea.Perform the Back Rocks basic step. On the 1st count, On 1 step in place, on 2-3 move forward...")
            //         ],
            //       ),
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => MovesDetailsRoute()),
            //       );
            //     },
            //   ),

            //   //=====================
            //   //=====================
            //   // new Transform(
            //   //   transform: new Matrix4.rotationZ(math.pi/2).scaled(0.5),
            //   //   alignment: FractionalOffset.center,
            //   //   child: goToNextAnimationView,
            //   // ),

            //   InkWell(
            //     child: Container(
            //       width: 356,
            //       height: 377,
            //       color: Colors.white,
            //       child: Column(
            //         children: <Widget>[
            //           Image.asset(CustomImages.placeholder1),
            //           Row(
            //             children: <Widget>[
            //               Text("El Uno"),
            //               Spacer(
            //                 flex: 1,
            //               ),
            //               Image.asset(
            //                 CustomImages.like,
            //                 width: 20,
            //                 height: 20,
            //               )
            //             ],
            //           ),
            //           Text("Difficulty: 2 over 5"),
            //           Text(" "),
            //           Text(
            //               "Start with a right to right hold of the hands, Switch On 7 if coming from Guapea.Perform the Back Rocks basic step. On the 1st count, On 1 step in place, on 2-3 move forward...")
            //         ],
            //       ),
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => MovesDetailsRoute()),
            //       );
            //     },
            //   ),

            //   //=====================
            //   //=====================
            //   // new Transform(
            //   //   transform: new Matrix4.rotationZ(math.pi/2).scaled(0.5),
            //   //   alignment: FractionalOffset.center,
            //   //   child: goToNextAnimationView,
            //   // ),

            //   InkWell(
            //     child: Container(
            //       width: 356,
            //       height: 377,
            //       color: Colors.white,
            //       child: Column(
            //         children: <Widget>[
            //           Image.asset(CustomImages.placeholder1),
            //           Row(
            //             children: <Widget>[
            //               Text("El Uno"),
            //               Spacer(
            //                 flex: 1,
            //               ),
            //               Image.asset(
            //                 CustomImages.like,
            //                 width: 20,
            //                 height: 20,
            //               )
            //             ],
            //           ),
            //           Text("Difficulty: 2 over 5"),
            //           Text(" "),
            //           Text(
            //               "Start with a right to right hold of the hands, Switch On 7 if coming from Guapea.Perform the Back Rocks basic step. On the 1st count, On 1 step in place, on 2-3 move forward...")
            //         ],
            //       ),
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => MovesDetailsRoute()),
            //       );
            //     },
            //   ),
            //   //=====================
            //   _ratePerformanceButton(),
            // ]),
      ),),
    );
  }

}

// class MovesListingRoute extends StatelessWidget {

//   Widget _refreshMovesButton() {
//     return FloatingActionButton(
//       onPressed: () => controller.flushMovesButtonPressed(),
//       tooltip: 'Flush Salsa Moves',
//       child: Icon(Icons.refresh),
//     );
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     var goToNextAnimationView = Lottie.asset(
//         'assets/animations/Onboarding_Slide_Left_Arrows_Animation.json');

//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
//       floatingActionButton: Container(
//         padding: EdgeInsets.only(top: 100),
//         child: FloatingActionButton(
//             backgroundColor: Colors.black,
//             tooltip: 'Flush Salsa Moves',
//             child: Icon(Icons.refresh),
//             onPressed: () => {print("refresh !")}),
//       ),
//       appBar: AppBar(
//         title: Text(
//           'Salsa Coach',
//           style: GoogleFonts.salsa(fontSize: 30),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Image.asset(CustomImages.trophy),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AchievementsRoute()),
//               );
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: //Column(children: <Widget>[
//             ListView(
//                 padding: const EdgeInsets.all(8)
//                     .add(EdgeInsets.only(top: 100))
//                     .add(EdgeInsets.only(bottom: 50)),
//                 children: <Widget>[
//               //=====================
//               // new Transform(
//               //   transform: new Matrix4.rotationZ(math.pi/2).scaled(0.5),
//               //   alignment: FractionalOffset.center,
//               //   child: goToNextAnimationView,
//               // ),

//               InkWell(
//                 child: Container(
//                   width: 356,
//                   height: 377,
//                   color: Colors.white,
//                   child: Column(
//                     children: <Widget>[
//                       Image.asset(CustomImages.placeholder1),
//                       Row(
//                         children: <Widget>[
//                           Text("El Uno",
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w900)),
//                           Spacer(
//                             flex: 1,
//                           ),
//                           Image.asset(
//                             CustomImages.like,
//                             width: 20,
//                             height: 20,
//                           )
//                         ],
//                       ),
//                       Container(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Difficulty: 2 over 5",
//                             textAlign: TextAlign.left,
//                           )),
//                       Text(" "),
//                       Text(
//                           "Start with a right to right hold of the hands, Switch On 7 if coming from Guapea.Perform the Back Rocks basic step. On the 1st count, On 1 step in place, on 2-3 move forward...")
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => MovesDetailsRoute()),
//                   );
//                 },
//               ),

//               //=====================
//               //=====================
//               // new Transform(
//               //   transform: new Matrix4.rotationZ(math.pi/2).scaled(0.5),
//               //   alignment: FractionalOffset.center,
//               //   child: goToNextAnimationView,
//               // ),

//               InkWell(
//                 child: Container(
//                   width: 356,
//                   height: 377,
//                   color: Colors.white,
//                   child: Column(
//                     children: <Widget>[
//                       Image.asset(CustomImages.placeholder1),
//                       Row(
//                         children: <Widget>[
//                           Text("El Uno"),
//                           Spacer(
//                             flex: 1,
//                           ),
//                           Image.asset(
//                             CustomImages.like,
//                             width: 20,
//                             height: 20,
//                           )
//                         ],
//                       ),
//                       Text("Difficulty: 2 over 5"),
//                       Text(" "),
//                       Text(
//                           "Start with a right to right hold of the hands, Switch On 7 if coming from Guapea.Perform the Back Rocks basic step. On the 1st count, On 1 step in place, on 2-3 move forward...")
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => MovesDetailsRoute()),
//                   );
//                 },
//               ),

//               //=====================
//               //=====================
//               // new Transform(
//               //   transform: new Matrix4.rotationZ(math.pi/2).scaled(0.5),
//               //   alignment: FractionalOffset.center,
//               //   child: goToNextAnimationView,
//               // ),

//               InkWell(
//                 child: Container(
//                   width: 356,
//                   height: 377,
//                   color: Colors.white,
//                   child: Column(
//                     children: <Widget>[
//                       Image.asset(CustomImages.placeholder1),
//                       Row(
//                         children: <Widget>[
//                           Text("El Uno"),
//                           Spacer(
//                             flex: 1,
//                           ),
//                           Image.asset(
//                             CustomImages.like,
//                             width: 20,
//                             height: 20,
//                           )
//                         ],
//                       ),
//                       Text("Difficulty: 2 over 5"),
//                       Text(" "),
//                       Text(
//                           "Start with a right to right hold of the hands, Switch On 7 if coming from Guapea.Perform the Back Rocks basic step. On the 1st count, On 1 step in place, on 2-3 move forward...")
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => MovesDetailsRoute()),
//                   );
//                 },
//               ),
//               //=====================
//               RaisedButton(
//                 color: Color(0xFFF7B60E),
//                 child: Text(
//                   'Done !',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   print('TODO: Open Dialog');
//                 },
//               ),
//             ]),
//       ),
//     );
//   }
// }
