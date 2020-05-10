import 'package:flutter_test/flutter_test.dart';
import 'package:salsa_memo/src/data/repositories/in_memory_moves_repository.dart';
import 'package:salsa_memo/src/domain/entities/move.dart';
import 'package:salsa_memo/src/domain/repositories/random_generator.dart';
import 'package:salsa_memo/src/domain/usecases/get_all_moves_usecase.dart';

class RandomGeneratorMock implements RandomGenerator {
  RandomGeneratorMock(List<Move> value) { 
    this.value = value;
  }
  List<Move> value;
  
  @override
  List<Move> rand(List<Move> moves) {
    return this.value;
  }

}

void main() {
  test('Staged moves randomly chosed', () async {
    var moves = [
      Move("Sombrero", "", "", "", 1), 
      Move("El Uno", "", "", "", 2),
      Move("El Dos", "", "", "", 3),
      Move("Exhibela", "", "", "", 2)
    ];
    var expected = [
      Move("El Uno", "", "", "", 2),
      Move("Exhibela", "", "", "", 2)
    ];
    var randomGenerator = RandomGeneratorMock(expected);
    var count = 2;

    var sut = GetAllMovesUseCase(InMemoryMovesRepository(moves), randomGenerator);

    var response = await sut.buildUseCaseStream(GetAllMovesUseCaseParams(count));
    response.forEach((element) {
      print(element.moves);
      expect(element.moves, expected);
    });
  });
}


