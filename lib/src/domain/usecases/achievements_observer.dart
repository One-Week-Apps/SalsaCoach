import 'package:salsa_coach/src/domain/entities/achievement_types.dart';

abstract mixin class AchievementsObserver {
  void update(AchievementTypes type);
}
