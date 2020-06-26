import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:salsa_memo/src/app/pages/achievements/achievements_presenter.dart';
import 'package:salsa_memo/src/domain/entities/achievement.dart';
import 'package:salsa_memo/src/domain/entities/achievement_types.dart';
import 'package:salsa_memo/src/domain/usecases/achievements_observer.dart';
import 'package:salsa_memo/src/domain/usecases/achievements_usecase.dart';

class AchievementsController extends Controller with AchievementsObserver {
  List<Achievement> _achievements;

  // data used by the View
  List<Achievement> get achievements => _achievements;

  final AchievementsPresenter presenter = AchievementsPresenter();

  @override
  void initListeners() {
    presenter.getAllAchievementsOnNext = (List<Achievement> achievements) {
      print(achievements.toString());
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
  }
}
