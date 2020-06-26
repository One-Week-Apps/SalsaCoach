import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:salsa_memo/src/data/repositories/in_memory_performance_repository.dart';
import 'package:salsa_memo/src/data/repositories/random_moves_generator.dart';
import 'package:salsa_memo/src/domain/entities/performance.dart';
import 'package:salsa_memo/src/domain/usecases/get_performances_usecase.dart';
import 'package:salsa_memo/src/domain/usecases/rate_performance_usecase.dart';

import '../../../domain/usecases/get_all_moves_usecase.dart';
import '../../../domain/usecases/get_user_usecase.dart';

class HomePresenter extends Presenter {
  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;

  Function getAllMovesOnNext;

  Function addPerformanceOnNext;

  Function getPerformancesOnNext;

  final GetUserUseCase getUserUseCase;
  final GetAllMovesUseCase getAllMovesUseCase;
  final RatePerformanceUseCase ratePerformanceUseCase;
  final GetPerformancesUseCase getPerformancesUseCase;

  HomePresenter(usersRepo, movesRepo)
      : getUserUseCase = GetUserUseCase(usersRepo),
        getAllMovesUseCase =
            GetAllMovesUseCase(movesRepo, RandomMovesGenerator()),
        getPerformancesUseCase =
            GetPerformancesUseCase(SharedPreferencesPerformanceRepository()),
        ratePerformanceUseCase =
            RatePerformanceUseCase(SharedPreferencesPerformanceRepository());

  void getUser(String uid) {
    getUserUseCase.execute(
        _GetUserUseCaseObserver(this), GetUserUseCaseParams(uid));
  }

  void getAllMoves() {
    int movesToPerformCount = 5;
    getAllMovesUseCase.execute(_GetAllMovesUseCaseObserver(this),
        GetAllMovesUseCaseParams(movesToPerformCount));
  }

  void addPerformance(Performance perf) {
    ratePerformanceUseCase.execute(
        _AddPerformanceUseCaseObserver(this),
        RatePerformanceUseCaseParams(perf)
    );
  }

  void getAllPerformances() {
    getPerformancesUseCase.execute(
        _GetAllPerformancesUseCaseObserver(this),
        GetAllPerformancesUseCaseParams());
  }

  @override
  void dispose() {
    getUserUseCase.dispose();
    getAllMovesUseCase.dispose();
  }
}

class _AddPerformanceUseCaseObserver extends Observer<RatePerformanceUseCaseResponse> {
  final HomePresenter presenter;

  _AddPerformanceUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    assert(presenter.getUserOnNext != null);
    presenter.addPerformanceOnNext();
  }

}

class _GetAllPerformancesUseCaseObserver extends Observer<GetAllPerformancesUseCaseResponse> {
  final HomePresenter presenter;

  _GetAllPerformancesUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    assert(presenter.getPerformancesOnNext != null);
    presenter.getPerformancesOnNext(response.perfs);
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
