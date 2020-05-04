/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalPerformances, String>> _createSampleData() {
    final data = [
      new OrdinalPerformances('Mon', 2),
      new OrdinalPerformances('Tue', 1),
      new OrdinalPerformances('Wed', 0),
      new OrdinalPerformances('Thu', 1),
      new OrdinalPerformances('Fri', 2),
      new OrdinalPerformances('Sat', 0),
      new OrdinalPerformances('Sun', 3),
    ];

    return [
      new charts.Series<OrdinalPerformances, String>(
        id: 'Progress',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
        domainFn: (OrdinalPerformances performances, _) => performances.day,
        measureFn: (OrdinalPerformances performances, _) => performances.performanceCount,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalPerformances {
  final String day;
  final int performanceCount;

  OrdinalPerformances(this.day, this.performanceCount);
}