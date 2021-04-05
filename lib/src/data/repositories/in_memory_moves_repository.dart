import 'package:salsa_coach/src/domain/entities/move.dart';
import 'package:salsa_coach/src/domain/repositories/moves_repository.dart';

class InMemoryMovesRepository extends MovesRepository {
  List<Move> moves;
  InMemoryMovesRepository(this.moves);
  
  @override
  Future<List<Move>> getAllMoves() async {
    return moves;
  }
  
}
