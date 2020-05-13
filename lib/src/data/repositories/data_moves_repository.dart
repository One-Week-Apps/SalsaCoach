import '../../domain/entities/move.dart';

import '../../domain/repositories/moves_repository.dart';

class DataMovesRepository extends MovesRepository {
  List<Move> moves;
  static DataMovesRepository _instance = DataMovesRepository._internal();
  DataMovesRepository._internal() {
    moves = List<Move>();
    moves.addAll([
      Move('Sombrero', 'Key Times: 4 * 4', 'The Sombrero move', 'https://www.youtube.com/embed/AqnNTeRs2Pw', 1),
      Move('El Uno', 'Key Times: 4 * 4', 'The El Uno move', 'https://www.youtube.com/embed/Imw-H_bQb1c', 2),
      Move('El Dos', 'Key Times: 4 * 4', 'The El Dos move', 'https://www.youtube.com/embed/WQXHNy77fgY', 2),
      Move('Montana', 'Key Times: 4 * 4', 'The Sombrero Manolito move', 'https://www.youtube.com/embed/A8MCYkUZRXk', 2),
      Move('Coca Cola', 'Key Times: 4 * 4', 'The Coca Cola move', 'https://www.youtube.com/embed/C8N58KGoGyw', 2),
      Move('Kentucky', 'Key Times: 4 * 4', 'The Kentucky move', 'https://www.youtube.com/embed/6CXoxcQ3bAk', 2),
      Move('Tour Magico', 'Key Times: 4 * 4', 'The Tour Magico move', 'https://www.youtube.com/embed/mG_J0xQy8O8', 2),
      Move('Vacilala Vacilense', 'Key Times: 4 * 4', 'The Vacilala Vacilense move', 'https://www.youtube.com/embed/Obl71WOOjJ4', 2),
      Move('Enchufela Doble', 'Key Times: 4 * 4', 'The Enchufela Doble move', 'https://www.youtube.com/embed/r2KcM4wxOC4', 2),
      Move('Exhibela Doble', 'Key Times: 4 * 4', 'The Exhibela Doble move', 'https://www.youtube.com/embed/o4nkV-0Ts9Q', 2),
    ]);
  }
  factory DataMovesRepository() => _instance;

  @override
  Future<List<Move>> getAllMoves() async {
    return moves;
  }
}
