import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:salsa_coach/src/app/pages/achievements/achievements_presenter.dart';
import 'package:salsa_coach/src/domain/entities/achievement.dart';
import 'package:salsa_coach/src/domain/entities/achievement_types.dart';
import 'package:salsa_coach/src/domain/usecases/achievements_observer.dart';
import 'package:salsa_coach/src/domain/usecases/achievements_usecase.dart';

import 'package:oktoast/oktoast.dart';

class AchievementsController extends Controller with AchievementsObserver {
  List<Achievement> _achievements;

  // data used by the View
  List<Achievement> get achievements => _achievements;

  final AchievementsPresenter presenter = AchievementsPresenter();

  @override
  void initListeners() {
    presenter.getAllAchievementsOnNext = (List<Achievement> achievements) {
      print("AAAAAAAAA" + achievements.toString());
      _achievements = achievements;
      refreshUI();
    };
  }

  void executeAchievements(AchievementsRequestType type, String id) =>
      presenter.getAllAchievements(type, id);

  @override
  void dispose() {
    presenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }

  @override
  void update(AchievementTypes type) {
    print("update for " + type.toString());

    //ensure all achievements have been fetched
    //print("OK1");
    //executeAchievements(AchievementsRequestType.doFetch, null);
    if (presenter.getAchievementsUseCase.fetchedAchievements == null) {
      executeAchievements(AchievementsRequestType.doFetch, null);
    }

    //foreach objective in fetched list, we increment the progress and trigger the Step use case if needed
    var didShowToast = false;
    for (int i = 0; i < presenter.getAchievementsUseCase.fetchedAchievements.length; i++)
    {
        if (presenter.getAchievementsUseCase.fetchedAchievements[i].type == type)
        {
            if (presenter.getAchievementsUseCase.fetchedAchievements[i].currentStep >= presenter.getAchievementsUseCase.fetchedAchievements[i].numberOfStep)
              continue;

            print("FOUND " + presenter.getAchievementsUseCase.fetchedAchievements[i].name + presenter.getAchievementsUseCase.fetchedAchievements[i].currentStep.toString());

            if (!didShowToast) {
              didShowToast = true;

              //final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
              //showToastWidget(Text("" + presenter.getAchievementsUseCase.fetchedAchievements[i].name + ": " + presenter.getAchievementsUseCase.fetchedAchievements[i].currentStep.toString() + "/" + presenter.getAchievementsUseCase.fetchedAchievements[i].numberOfStep.toString() + " ✅"));
              showToast("" + presenter.getAchievementsUseCase.fetchedAchievements[i].name + ": " + (presenter.getAchievementsUseCase.fetchedAchievements[i].currentStep + 1).toString() + "/" + presenter.getAchievementsUseCase.fetchedAchievements[i].numberOfStep.toString() + " ✅");
              /*Scaffold.of(AppConstants.appContext).showSnackBar(SnackBar( //_key.currentState.showSnackBar(SnackBar(
                content: Text("" + presenter.getAchievementsUseCase.fetchedAchievements[i].name + ": " + presenter.getAchievementsUseCase.fetchedAchievements[i].currentStep.toString() + "/" + presenter.getAchievementsUseCase.fetchedAchievements[i].numberOfStep.toString() + " ✅"),
              ));*/
            }

            executeAchievements(AchievementsRequestType.doStep, presenter.getAchievementsUseCase.fetchedAchievements[i].uid);
        }
    }

    //executeAchievements(AchievementsRequestType.doFetch, null);
  }
}
