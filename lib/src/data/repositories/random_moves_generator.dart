import 'package:salsa_coach/src/domain/entities/move.dart';
import 'package:salsa_coach/src/domain/repositories/random_generator.dart';

class RandomMovesGenerator implements RandomGenerator {
  
  @override
  List<Move> rand(List<Move> moves) {
    return moves.toList()..shuffle();
  }

}