import '../entities/achievement.dart';

abstract class AchievementsRepository {
  Future<Achievement> validateAchievement(String uid);
  Future<List<Achievement>> getAllAchievements();
}
