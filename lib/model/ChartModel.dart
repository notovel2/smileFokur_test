import 'package:smile_fokus_test/model/ChartData.dart';

class ChartModel {
  ChartModel({
    this.datalist,
    this.total,
    this.totalCurrentYear
  });
  List<ChartData> datalist;
  num total;
  num totalCurrentYear;
}