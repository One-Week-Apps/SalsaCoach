import '../../domain/entities/move.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/moves_repository.dart';

class DataMovesRepository extends MovesRepository {
  List<Move> moves;
  static DataMovesRepository _instance = DataMovesRepository._internal();
  DataMovesRepository._internal() {
    moves = List<Move>();
    moves.addAll([
      Move('Sombrero', 'Tempo: 4 * 4', 'The Sombrero move', 'https://www.youtube.com/embed/AqnNTeRs2Pw', 1),
      Move('El Uno', 'Tempo: 4 * 4', 'The El Uno move', 'https://www.youtube.com/embed/Imw-H_bQb1c', 2),
      Move('El Dos', 'Tempo: 4 * 4', 'The El Dos move', 'https://www.youtube.com/embed/WQXHNy77fgY', 2),
    ]);
  }
  factory DataMovesRepository() => _instance;

  @override
  Future<List<Move>> getAllMoves() async {
    return moves;
  }
}
