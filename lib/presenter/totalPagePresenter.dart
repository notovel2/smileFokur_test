import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/Segment.dart';
import 'package:smile_fokus_test/model/chart/ChartModel.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';
import 'package:smile_fokus_test/utils/dateUtil.dart';
import 'package:smile_fokus_test/view/totalPage.dart';

class TotalPagePresenter {
  TotalPagePresenter({
    this.displayType = DisplayType.month,
  }): this._dateFormat = DateFormat(DateUtil.getPattern(displayType));
  final DisplayType displayType;
  final DateFormat _dateFormat;
  final NumberFormat _numberFormat = NumberFormat("#,###.##");
  TotalPage view;
  List<Segment> getSegmentlist(List<OverviewChartModel> chartdatalist, List<DateTime> periodList) {
    List<Segment> segmentlist = [];
    periodList = (periodList == null) ? [] : periodList;
    List<OverviewChartModel> tmpChartDatalist = chartdatalist;
    if(periodList.isNotEmpty) {
      tmpChartDatalist = chartdatalist.where((chartData) => 
                                                  periodList.contains(chartData.period))
                                        .toList();
    }
    segmentlist.addAll([
      Segment(
        title: "by Gender", 
        datamap: _getGenderMap(tmpChartDatalist)
      ),
      Segment(
        title: "by Age Range",
        datamap: _getAgeMap(tmpChartDatalist)
      ),
      Segment(
        title: "by Branch",
        datamap: _getBranchesMap(tmpChartDatalist)
      ),
      Segment(
        title: "by Tier",
        datamap: _getTierMap(tmpChartDatalist)
      )
    ]);
    return segmentlist;
  }

  Map<String, ChartModel> _setColor(Map<String, ChartModel> chartMap) {
    Map<String, ChartModel> tmpMap = chartMap;
    num maximum = tmpMap.values
                          .toList()
                          .fold(
                            0, 
                            (cur, next) => (cur > next.measure) ? cur : next.measure
                          );
    tmpMap.updateAll((key, value) {
      value.color = (value.measure >= maximum) ? charts.Color.fromHex(code: CustomColors.orange.hex) : value.color;
      return value;
    });
    return tmpMap;
  }

  Map<String, ChartModel> _getGenderMap(List<OverviewChartModel> chartdatalist) {
    Map<String, ChartModel> genderMap = chartdatalist.fold({
      "gentleman": ChartModel(
        domain: "gentleman", 
        measure: 0, 
        color: charts.Color.fromHex(code: CustomColors.gray.hex)),
      "lady": ChartModel(
        domain: "lady", 
        measure: 0, 
        color: charts.Color.fromHex(code: CustomColors.gray.hex)),
      "other": ChartModel(
        domain: "other", 
        measure: 0, 
        color: charts.Color.fromHex(code: CustomColors.gray.hex)),
    }, 
    (cur, next) {
      cur["gentleman"].measure += next.gender.gentleMan;
      cur["lady"].measure += next.gender.lady;
      cur["other"].measure += next.gender.other;
      return cur;
    });
    return _setColor(genderMap);
  }

  Map<String, ChartModel> _getAgeMap(List<OverviewChartModel> chartdatalist) {
    Map<String, ChartModel> ageMap = chartdatalist.fold(
      {}, 
      (cur, next) {
        return next.agelist.fold(Map.from(cur), (result, age){
          result.update(age.range, 
                        (data) => data.addMeassure(age.value), 
                        ifAbsent: () => ChartModel(domain: age.range,
                                                    measure: age.value,
                                                    color: charts.Color.fromHex(code: CustomColors.gray.hex)));
          return result;
        });
      }
    );
    return _setColor(ageMap);
  }

  Map<String, ChartModel> _getBranchesMap(List<OverviewChartModel> chartdatalist) {
    Map<String, ChartModel> branchesMap = chartdatalist.fold(
      {}, 
      (cur, next) {
        return next.branches.fold(Map.from(cur), (result, branch){
          result.update(branch.place, 
                        (data) => data.addMeassure(branch.value), 
                        ifAbsent: () => ChartModel(measure: branch.value,
                                                    domain: branch.place,
                                                    color: charts.Color.fromHex(code: CustomColors.gray.hex)));
          return result;
        });
      }
    );
    return _setColor(branchesMap);
  }

  Map<String, ChartModel> _getTierMap(List<OverviewChartModel> chartdatalist) {
    Map<String, ChartModel> tierMap = chartdatalist.fold({
      "starter": ChartModel(
        domain: "starter", 
        measure: 0, 
        color: charts.Color.fromHex(code: CustomColors.gray.hex)),
      "silver": ChartModel(
        domain: "silver", 
        measure: 0, 
        color: charts.Color.fromHex(code: CustomColors.gray.hex)),
      "gold": ChartModel(
        domain: "gold", 
        measure: 0, 
        color: charts.Color.fromHex(code: CustomColors.gray.hex)),
      "platinum": ChartModel(
        domain: "platinum",
        measure: 0, 
        color: charts.Color.fromHex(code: CustomColors.gray.hex)),
    }, 
    (cur, next) {
      cur["starter"].measure += next.tier.starter;
      cur["silver"].measure += next.tier.silver;
      cur["gold"].measure += next.tier.gold;
      cur["platinum"].measure += next.tier.platinum;
      return cur;
    });
    return _setColor(tierMap);
  }
  
  String getSegmentationHeader(DateTime currentPeriod, OverviewChartModel summaryData, String currency) {
    return (currentPeriod == null) 
                ? "All" 
                : "${_dateFormat.format(currentPeriod)} (${_numberFormat.format(summaryData.mainAmount.active)} $currency)";
  }

  OverviewChartModel getSummaryData(List<OverviewChartModel> chartdatalist, DateTime currentPeriod) {
    return (currentPeriod != null) ? chartdatalist.firstWhere((data) => data.period == currentPeriod) 
                  : null;
  }
}