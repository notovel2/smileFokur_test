import 'package:charts_flutter/flutter.dart' as charts;

class ChartModel {
  ChartModel({
    this.domain,
    this.measure,
    this.color
  });
  final String domain;
  num measure;
  charts.Color color;
  ChartModel addMeassure(num addMeasure) {
    measure += addMeasure;
    return this;
  }
}