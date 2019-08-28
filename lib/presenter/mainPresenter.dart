import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/MainModel.dart';
import 'package:smile_fokus_test/model/chart/BranchSummaryChartModel.dart';
import 'package:smile_fokus_test/model/chart/ChartData.dart';
import 'package:smile_fokus_test/services/api.dart';
import 'package:smile_fokus_test/view/mainPage.dart';

class MainPresenter {
  MainPage view;
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
    List<ChartData> chartData = (response['data'] as List)
                                        .map((item) => ChartData.fromJson(item))
                                        .toList();
    List<BranchSummary> branchlist = (response['branch_summary'] as List)
                                        .map((item) => BranchSummary.fromJson(item))
                                        .toList();
    branchlist.sort((a, b) => b.value.compareTo(a.value));
    branchlist = (branchlist.length > 5) ? branchlist.sublist(0, 5) : branchlist;
    if(branchlist.length > 0) {
      branchlist[0].color = CustomColors.orange.hex;
      branchlist[1].color = CustomColors.orangeOpacity.hex;
    }
    branchlist.sort((a, b) => a.place.compareTo(b.place));
    chartData = ((chartData.length) - 12 > 0) ? chartData.sublist(chartData.length - 12) : chartData;
    return MainChartResponse(
      datalist: chartData,
      total: response['total'] as num,
      totalCurrentYear: response['total_current_year'] as num,
      branchSummaryList: branchlist
    );
  }
}
