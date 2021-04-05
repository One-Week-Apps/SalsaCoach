import 'package:flutter_test/flutter_test.dart';
import 'package:salsa_coach/src/data/repositories/remote_moves_repository.dart';

void main() {

  test('Moves are fetched from remote website', () async {
    var sut = RemoteMovesRepository();

    var moves = await sut.getAllMoves();

    expect(moves.length, 1);
    expect(moves[0].name, 'Sombrero');
  });

}
