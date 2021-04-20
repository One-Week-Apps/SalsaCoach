import 'package:salsa_coach/src/domain/entities/achievement_types.dart';

class Achievement {
  final String uid;
  final AchievementTypes type;
  final String name;
  final String description;
  final bool isLocal;

  bool isRewardClaimed;
  int currentStep;
  int numberOfStep;

  Achievement(this.uid, this.type, this.name, this.description, this.isLocal,
      this.isRewardClaimed, this.currentStep, this.numberOfStep);

  @override
  String toString() =>
      '$uid, $name, $currentStep, $numberOfStep';
}
