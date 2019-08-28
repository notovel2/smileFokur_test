import 'package:smile_fokus_test/model/chart/ChartData.dart';
import 'package:smile_fokus_test/model/chart/ChartModel.dart';

class OverviewChartModel implements ChartModel<ChartData> {
  OverviewChartModel({
    this.datalist,
    this.total,
    this.totalCurrentYear,
    this.latestData
  });
  num total;
  num totalCurrentYear;
  @override
  List<ChartData> datalist;

  @override
  ChartData latestData;

}