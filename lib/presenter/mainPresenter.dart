import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/MainModel.dart';
import 'package:smile_fokus_test/model/chart/BranchSummaryChartModel.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';
import 'package:smile_fokus_test/services/api.dart';
import 'package:smile_fokus_test/view/mainPage.dart';

class MainPresenter {
  MainPage view;

  List _sublist<T>(List datalist, int size, int Function(dynamic,dynamic) comparatorFn) {
    datalist.sort(comparatorFn);
    return (datalist.length - size > 0) ? datalist.sublist(0, size) : datalist;
  }

  MainChartResponse getChartData(DataType type) {
    Map<String, dynamic> response;
    switch (type) {
      case DataType.revenue:
        response = Api.getData(DataType.revenue);
        break;
      case DataType.member:
        response = Api.getData(DataType.member);
        break;
    }
    List<OverviewChartModel> chartData = (response['data'] as List)
                                        .map((item) => OverviewChartModel.fromJson(item))
                                        .toList();
    List<BranchSummary> branchlist = (response['branch_summary'] as List)
                                        .map((item) => BranchSummary.fromJson(item))
                                        .toList();
    chartData = _sublist(chartData, 12, (a, b) => b.period.compareTo(a.period));
    branchlist = _sublist(branchlist, 5, (a, b) => b.value.compareTo(a.value)) as List<BranchSummary>;
    if(branchlist.length > 0) {
      branchlist[0].color = CustomColors.orange.hex;
      branchlist[1].color = CustomColors.orangeOpacity.hex;
    }
    branchlist.sort((a, b) => a.place.compareTo(b.place));
    return MainChartResponse(
      datalist: chartData,
      total: response['total'] as num,
      totalCurrentYear: response['total_current_year'] as num,
      branchSummaryList: branchlist,
    );
  }
}
