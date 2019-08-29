import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/model/Segment.dart';
import 'package:smile_fokus_test/model/chart/ChartModel.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';
import 'package:smile_fokus_test/view/totalPage.dart';

class TotalPagePresenter {
  TotalPage view;
  List<Segment> getSegmentlist(List<OverviewChartModel> chartdatalist) {
    List<Segment> segmentlist = [];
    segmentlist.addAll([
      Segment(
        title: "by Gender", 
        datamap: _getGenderMap(chartdatalist)
      ),
      Segment(
        title: "by Age Range",
        datamap: _getAgeMap(chartdatalist)
      ),
      Segment(
        title: "by Branch",
        datamap: _getBranchesMap(chartdatalist)
      ),
      Segment(
        title: "by Tier",
        datamap: _getTierMap(chartdatalist)
      )
    ]);
    return segmentlist;
  }

  Map<String, ChartModel> _getGenderMap(List<OverviewChartModel> chartdatalist) {
    return chartdatalist.fold(
      {
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
  }

  Map<String, ChartModel> _getAgeMap(List<OverviewChartModel> chartdatalist) {
    return chartdatalist.fold(
      {}, 
      (cur, next) {
        return next.agelist.fold(Map.from(cur), (result, age){
          result.update(age.range, 
                        (data) => data.addMeassure(age.value), 
                        ifAbsent: () => ChartModel(measure: age.value));
          return result;
        });
      }
    );
  }

  Map<String, ChartModel> _getBranchesMap(List<OverviewChartModel> chartdatalist) {
    return chartdatalist.fold(
      {}, 
      (cur, next) {
        return next.branches.fold(Map.from(cur), (result, branch){
          result.update(branch.place, 
                        (data) => data.addMeassure(branch.value), 
                        ifAbsent: () => ChartModel(measure: branch.value));
          return result;
        });
      }
    );
  }

  Map<String, ChartModel> _getTierMap(List<OverviewChartModel> chartdatalist) {
    return chartdatalist.fold(
      {
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
  }
}