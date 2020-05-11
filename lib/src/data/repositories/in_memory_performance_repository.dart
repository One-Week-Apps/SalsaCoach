import 'package:salsa_memo/src/domain/entities/performance_score.dart';
import 'package:salsa_memo/src/domain/repositories/performance_repository.dart';

class InMemoryPerformanceRepository extends PerformanceRepository {
  List<Performance> _perfs;
  InMemoryPerformanceRepository(this._perfs);

  @override
  Future<bool> add(Performance performance) async {
    this._perfs.add(performance);
    return true;
  }
  
  @override
  Future<List<Performance>> all() async {
    return _perfs;
  }
  
}