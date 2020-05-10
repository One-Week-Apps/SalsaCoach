import 'dart:async';

import 'package:salsa_memo/src/domain/repositories/random_generator.dart';

import '../entities/move.dart';
import '../repositories/moves_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetAllMovesUseCase
    extends UseCase<GetAllMovesUseCaseResponse, GetAllMovesUseCaseParams> {
  final MovesRepository movesRepository;
  final RandomGenerator randomGenerator;
  GetAllMovesUseCase(this.movesRepository, this.randomGenerator);

  @override
  Future<Stream<GetAllMovesUseCaseResponse>> buildUseCaseStream(
      GetAllMovesUseCaseParams params) async {
    final StreamController<GetAllMovesUseCaseResponse> controller =
        StreamController();
    try {
      // get moves
      List<Move> moves = await movesRepository.getAllMoves();
      // filter moves
      var randomMoves = randomGenerator.rand(moves).sublist(0, params.count);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetAllMovesUseCaseResponse(randomMoves));
      logger.finest('GetMoveUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetMoveUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class GetAllMovesUseCaseParams {
  int count;
  GetAllMovesUseCaseParams(this.count);
}

/// Wrapping response inside an object makes it easier to change later
class GetAllMovesUseCaseResponse {
  List<Move> moves;
  GetAllMovesUseCaseResponse(this.moves);
}
