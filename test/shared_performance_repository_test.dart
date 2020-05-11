import 'package:flutter_test/flutter_test.dart';
import 'package:salsa_memo/src/data/repositories/in_memory_performance_repository.dart';
import 'package:salsa_memo/src/domain/entities/performance_score.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  test('Read with no performance', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    var sut = SharedPreferencesPerformanceRepository();

    var perfs = await sut.all();

    expect(perfs, []);
  });

  test('Read with one performance', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    var sut = SharedPreferencesPerformanceRepository();

    var score = PerformanceScore(1, 2, 3, 1, 2, 3, 1);
    var performance = Performance(0, score, DateTime.now());
    bool status = await sut.add(performance);

    expect(status, true);
    
    var perfs = await sut.all();
    var expectedPerfs = [performance];

    // TODO: Serialize Score ([Int])
    expect(perfs.map((e) => e.id), expectedPerfs.map((e) => e.id));
    expect(perfs.map((e) => e.dateTime.millisecondsSinceEpoch), expectedPerfs.map((e) => e.dateTime.millisecondsSinceEpoch));
  });

  test('Integration test', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    var sut = SharedPreferencesPerformanceRepository();

    var score = PerformanceScore(1, 2, 3, 1, 2, 3, 1);
    var performance = Performance(0, score, DateTime.now());
    bool status = await sut.add(performance);
    print("Added ${performance.id}: $status");

    performance = Performance(1, score, DateTime.now());
    status = await sut.add(performance);
    print("Added ${performance.id}: $status");

    performance = Performance(2, score, DateTime.now());
    status = await sut.add(performance);
    print("Added ${performance.id}: $status");

    performance = Performance(3, score, DateTime.now());
    status = await sut.add(performance);
    print("Added ${performance.id}: $status");
    // var perfs = await sut.all();

    // print(perfs);

    //expect(perfs, []);
  });

}


