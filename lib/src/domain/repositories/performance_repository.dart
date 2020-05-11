import 'package:salsa_memo/src/domain/entities/performance_score.dart';

abstract class PerformanceRepository {
  Future<bool> add(Performance performance);
  Future<List<Performance>> all();
}
