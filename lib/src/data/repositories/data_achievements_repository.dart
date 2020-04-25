import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/achievement.dart';
import '../../domain/repositories/achievements_repository.dart';

class DataAchievementsRepository extends AchievementsRepository {
  List<Achievement> achievements;
  static DataAchievementsRepository _instance = DataAchievementsRepository._internal();
  DataAchievementsRepository._internal() {
    achievements = List<Achievement>();
    achievements.addAll([
      Achievement(1, 'Finding your feet', 'Perform a first dance'),
      Achievement(1, 'Warm Up', 'Perform 3 consecutive days'),
      Achievement(1, 'Salsero', 'Perform 5 consecutive days'),
      Achievement(1, 'Performer', 'Perform 10 consecutive days'),
      Achievement(1, 'Star', 'Perform 25 consecutive days'),
    ]);
  }
  factory DataAchievementsRepository() => _instance;

  @override
  Future<List<Achievement>> getAllAchievements() async {
    return achievements;
  }

  @override
  Future<Achievement> validateAchievement(String uid) {
    return null;
  }
}
