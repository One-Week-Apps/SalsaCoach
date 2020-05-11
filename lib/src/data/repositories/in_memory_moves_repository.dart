import 'package:salsa_memo/src/domain/entities/move.dart';
import 'package:salsa_memo/src/domain/repositories/moves_repository.dart';

class InMemoryMovesRepository extends MovesRepository {
  List<Move> moves;
  InMemoryMovesRepository(this.moves);
  
  @override
  Future<List<Move>> getAllMoves() async {
    return moves;
  }
  
}
