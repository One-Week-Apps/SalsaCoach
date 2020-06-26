import 'package:flutter_test/flutter_test.dart';
import 'package:salsa_memo/src/app/widgets/simple_bar_chart.dart';
import 'package:salsa_memo/src/domain/entities/performance.dart';
import 'package:salsa_memo/src/domain/entities/performance_score.dart';

void main() {

  void _assertDays(Iterable days) {
    expect(days.length, 7);
    var expectedDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    for (var i = 0 ; i < expectedDays.length ; i++) {
      expect(days.elementAt(i), expectedDays[i]);
    }
  }

  test('For no performance, should display no performances', () {
    var sut = SimpleBarChart.withPerformances([]);

    var ordinalPerformances = sut.seriesList.first.data;
    var days = ordinalPerformances.map((e) => e.day);
    List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.performanceCount).toList();

    _assertDays(days);
    for (var index = 0 ; index < days.length ; index++) {
      expect(performanceCounts[index], 0);
    }
  });

  test('For one 1 star-performance on Wednesday, should display performance', () {
    var wednesdayDateTime = DateTime(2020, DateTime.may, 13);
    var sut = SimpleBarChart.withPerformances([
      Performance(0, PerformanceScore(1, 0, 0, 0, 0, 0, 0), wednesdayDateTime),
    ]);

    var ordinalPerformances = sut.seriesList.first.data;
    var days = ordinalPerformances.map((e) => e.day);
    List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.performanceCount).toList();

    _assertDays(days);
    for (var index = 0 ; index < days.length ; index++) {
      expect(performanceCounts[index], index == 2 ? 1 : 0);
    }
  });

  test('For one 2-stars performance on Wednesday, should display performances', () {
    var wednesdayDateTime = DateTime(2020, DateTime.may, 13);
    var sut = SimpleBarChart.withPerformances([
      Performance(0, PerformanceScore(1, 0, 1, 0, 0, 0, 0), wednesdayDateTime),
    ]);

    var ordinalPerformances = sut.seriesList.first.data;
    var days = ordinalPerformances.map((e) => e.day);
    List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.performanceCount).toList();

    _assertDays(days);
    for (var index = 0 ; index < days.length ; index++) {
      expect(performanceCounts[index], index == 2 ? 2 : 0);
    }
  });

  test('For one performance on Wednesday and one on Friday, should display performances', () {
    var wednesdayDateTime = DateTime(2020, DateTime.may, 13);
    var fridayDateTime = DateTime(2020, DateTime.may, 15);
    var sut = SimpleBarChart.withPerformances([
      Performance(0, PerformanceScore(1, 0, 0, 0, 0, 0, 0), wednesdayDateTime),
      Performance(0, PerformanceScore(1, 0, 0, 0, 0, 0, 0), fridayDateTime),
    ]);

    var ordinalPerformances = sut.seriesList.first.data;
    var days = ordinalPerformances.map((e) => e.day);
    List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.performanceCount).toList();

    _assertDays(days);
    for (var index = 0 ; index < days.length ; index++) {
      expect(performanceCounts[index], index == 2 || index == 4 ? 1 : 0);
    }
  });

}
