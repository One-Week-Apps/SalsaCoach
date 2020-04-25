import 'dart:async';

import '../entities/move.dart';
import '../repositories/moves_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetAllMovesUseCase
    extends UseCase<GetAllMovesUseCaseResponse, GetAllMovesUseCaseParams> {
  final MovesRepository movesRepository;
  GetAllMovesUseCase(this.movesRepository);

  @override
  Future<Stream<GetAllMovesUseCaseResponse>> buildUseCaseStream(
      GetAllMovesUseCaseParams params) async {
    final StreamController<GetAllMovesUseCaseResponse> controller =
        StreamController();
    try {
      // get moves
      List<Move> moves = await movesRepository.getAllMoves();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetAllMovesUseCaseResponse(moves));
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
  GetAllMovesUseCaseParams();
}

/// Wrapping response inside an object makes it easier to change later
class GetAllMovesUseCaseResponse {
  List<Move> moves;
  GetAllMovesUseCaseResponse(this.moves);
}
