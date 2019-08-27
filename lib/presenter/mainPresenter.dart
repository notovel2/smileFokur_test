import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/ChartData.dart';
import 'package:smile_fokus_test/model/ChartModel.dart';
import 'package:smile_fokus_test/services/api.dart';
import 'package:smile_fokus_test/view/mainView.dart';

class MainPresenter {
  MainView view;
  ChartModel getChartData(DataType type) {
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
    chartData = ((chartData.length) - 12 > 0) ? chartData.sublist(chartData.length - 12) : chartData;
    return ChartModel(
      datalist: chartData,
      total: response['total'] as num,
      totalCurrentYear: response['total_current_year'] as num
    );
  }

  ChartModel getPerformanceData(List<ChartData> chartData) {
    // chartData.sort((a, b) => a.branches > b.branches);
  }
}
