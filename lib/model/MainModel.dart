import 'package:smile_fokus_test/model/chart/BranchSummaryChartModel.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';

class MainModel {

}

class MainChartResponse {
  List<OverviewChartModel> datalist;
  num total;
  num totalCurrentYear;
  List<BranchSummary> branchSummaryList;
  MainChartResponse({
    this.datalist,
    this.total = 0,
    this.totalCurrentYear = 0,
    this.branchSummaryList,
  });
}