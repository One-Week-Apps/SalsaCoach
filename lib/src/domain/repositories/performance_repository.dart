import 'package:salsa_coach/src/domain/entities/performance.dart';

abstract class PerformanceRepository {
  Future<bool> add(Performance performance);
  Future<List<Performance>> all();
}
