import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:salsa_coach/src/domain/usecases/achievements_usecase.dart';

class AchievementsPresenter extends Presenter {
  Function getAllAchievementsOnNext;

  final AchievementsUseCase getAchievementsUseCase;

  AchievementsPresenter() : getAchievementsUseCase = AchievementsUseCase();

  void getAllAchievements(AchievementsRequestType type, String id) {
    print("OK2");
    getAchievementsUseCase.execute(_GetAllAchievementsUseCaseObserver(this),
        AchievementsUseCaseParams(type, id));
  }

  @override
  void dispose() {
    getAchievementsUseCase.dispose();
  }
}

class _GetAllAchievementsUseCaseObserver
    extends Observer<AchievementsUseCaseResponse> {
  final AchievementsPresenter presenter;

  _GetAllAchievementsUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    print("onComplete");
  }

  @override
  void onError(e) {
    print("onError" + e.toString());
  }

  @override
  void onNext(response) {
    print("onNext" + response.achievements.toString());
    assert(presenter.getAllAchievementsOnNext != null);
    print("onNext2");
    presenter.getAllAchievementsOnNext(response.achievements);
  }
}
