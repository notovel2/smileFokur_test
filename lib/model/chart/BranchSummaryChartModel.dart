import 'package:smile_fokus_test/model/chart/ChartModel.dart';

class BranchSummaryChartModel implements ChartModel<BranchSummary> {
  BranchSummaryChartModel({
    this.datalist,
    this.total,
    this.totalCurrentYear,
    this.branchSummaryList
  });
  
  num total;
  num totalCurrentYear;
  List<BranchSummary> branchSummaryList;
  @override
  List<BranchSummary> datalist;
}

class BranchSummary{
  BranchSummary({
    this.place,
    this.value
  });
  String place;
  num value;
  String color;

  BranchSummary.fromJson(Map<String, dynamic> json)
    : place = json['place'],
      value = json['value'];
}