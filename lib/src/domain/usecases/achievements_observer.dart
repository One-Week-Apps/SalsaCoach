import 'package:salsa_memo/src/domain/entities/achievement_types.dart';

abstract class AchievementsObserver {
  void update(AchievementTypes type);
}
