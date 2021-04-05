import 'package:salsa_coach/src/domain/entities/achievement_types.dart';
import 'package:salsa_coach/src/domain/usecases/achievements_observer.dart';

abstract class AchievementsObservee {
  void attach(AchievementsObserver o);

  void detach(AchievementsObserver o);

  void notify(AchievementTypes type);
}
