import 'package:salsa_memo/src/domain/entities/move.dart';

abstract class RandomGenerator {
  List<Move> rand(List<Move> moves);
}