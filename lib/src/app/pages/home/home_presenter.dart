import '../../../domain/usecases/get_all_moves_usecase.dart';
import '../../../domain/usecases/get_user_usecase.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;

  Function getAllMovesOnNext;

  final GetUserUseCase getUserUseCase;
  final GetAllMovesUseCase getAllMovesUseCase;
  HomePresenter(usersRepo, movesRepo) : getUserUseCase = GetUserUseCase(usersRepo), getAllMovesUseCase = GetAllMovesUseCase(movesRepo);

  void getUser(String uid) {
    // execute getUseruserCase
    getUserUseCase.execute(
        _GetUserUseCaseObserver(this), GetUserUseCaseParams(uid));
  }

  void getAllMoves() {
    getAllMovesUseCase.execute(
        _GetAllMovesUseCaseObserver(this),
        GetAllMovesUseCaseParams());
  }

  @override
  void dispose() {
    getUserUseCase.dispose();
    getAllMovesUseCase.dispose();
  }
}

class _GetAllMovesUseCaseObserver extends Observer<GetAllMovesUseCaseResponse> {
  final HomePresenter presenter;
  _GetAllMovesUseCaseObserver(this.presenter);
  @override
  void onComplete() {}
  @override
  void onError(e) {}
  @override
  void onNext(response) {
    assert(presenter.getUserOnNext != null);
    presenter.getAllMovesOnNext(response.moves);
  }
}

class _GetUserUseCaseObserver extends Observer<GetUserUseCaseResponse> {
  final HomePresenter presenter;
  _GetUserUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    assert(presenter.getUserOnComplete != null);
    presenter.getUserOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getUserOnError != null);
    presenter.getUserOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getUserOnNext != null);
    presenter.getUserOnNext(response.user);
  }
}
