import 'package:salsa_coach/src/domain/entities/move.dart';

abstract class RandomGenerator {
  List<Move> rand(List<Move> moves);
}