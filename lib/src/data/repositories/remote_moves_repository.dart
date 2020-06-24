import 'dart:io';

import '../../domain/entities/move.dart';

import '../../domain/repositories/moves_repository.dart';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RemoteMovesRepository extends MovesRepository {
  List<Move> moves;
  bool _doOnce = true;
  static RemoteMovesRepository _instance = RemoteMovesRepository._internal();
  RemoteMovesRepository._internal() {
    moves = List<Move>();
    // moves.addAll([
    //   Move('Sombrero', 'Key Times: 4 * 4', 'The Sombrero move', 'https://www.youtube.com/embed/AqnNTeRs2Pw', 1),
    //   Move('El Uno', 'Key Times: 4 * 4', 'The El Uno move', 'https://www.youtube.com/embed/Imw-H_bQb1c', 2),
    //   Move('El Dos', 'Key Times: 4 * 4', 'The El Dos move', 'https://www.youtube.com/embed/WQXHNy77fgY', 2),
    //   Move('Montana', 'Key Times: 4 * 4', 'The Sombrero Manolito move', 'https://www.youtube.com/embed/A8MCYkUZRXk', 2),
    //   Move('Coca Cola', 'Key Times: 4 * 4', 'The Coca Cola move', 'https://www.youtube.com/embed/C8N58KGoGyw', 2),
    //   Move('Kentucky', 'Key Times: 4 * 4', 'The Kentucky move', 'https://www.youtube.com/embed/6CXoxcQ3bAk', 2),
    //   Move('Tour Magico', 'Key Times: 4 * 4', 'The Tour Magico move', 'https://www.youtube.com/embed/mG_J0xQy8O8', 2),
    //   Move('Vacilala Vacilense', 'Key Times: 4 * 4', 'The Vacilala Vacilense move', 'https://www.youtube.com/embed/Obl71WOOjJ4', 2),
    //   Move('Enchufela Doble', 'Key Times: 4 * 4', 'The Enchufela Doble move', 'https://www.youtube.com/embed/r2KcM4wxOC4', 2),
    //   Move('Exhibela Doble', 'Key Times: 4 * 4', 'The Exhibela Doble move', 'https://www.youtube.com/embed/o4nkV-0Ts9Q', 2),
    //   Move('Cementario', 'Key Times: 4 * 4', 'The Cementario move', 'https://www.youtube.com/embed/itBdgUz4hMA', 3),
    //   Move('Nudo', 'Key Times: 4 * 4', 'The Nudo move', 'https://www.youtube.com/embed/cUHjbSiQU9Y', 3),
    // ]);
  }
  factory RemoteMovesRepository() => _instance;

  @override
  Future<List<Move>> getAllMoves() async {
    if (_doOnce) {
      _doOnce = false;

      final response = await http.Client().get(Uri.parse('https://salsayo.com/move/Sombrero'));

      // var wv = WebView(initialUrl: 'https://salsayo.com/move/Sombrero', javascriptMode: JavascriptMode.unrestricted,);
      // wv.

      if (response.statusCode == 200) {
        var document = parse(response.body);
        print(document.getElementsByTagName("moveTitle").length);

        moves.addAll([
          Move('Sombrero', 'Key Times: 4 * 4', 'The Sombrero move', 'https://www.youtube.com/embed/AqnNTeRs2Pw', 1),
        ]);
      }
    }

    return moves;
  }
}
