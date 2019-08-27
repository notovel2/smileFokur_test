import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/component/charts/CustomChart.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/model/ChartData.dart';
import 'package:smile_fokus_test/model/ChartModel.dart';


class PerformanceChart extends StatefulWidget implements CustomChart {
  PerformanceChart({Key key, 
                      this.chartDatalist, 
                      this.domainFn, 
                      this.measureFn, 
                      this.isVertical = true, 
                      this.id, 
                      this.title}) : super(key: key);
  @override
  _PerformanceChartState createState() => _PerformanceChartState();

  @override
  List<ChartData> chartDatalist;

  @override
  dynamic Function(ChartData, int) domainFn;

  @override
  String id;

  @override
  bool isVertical;

  @override
  num Function(ChartData, int) measureFn;

  @override
  String title;
}

class _PerformanceChartState extends State<PerformanceChart> {
  
  charts.Color _getColor(BranchSummary chartData, bool isLast) {
    DateTime now = DateTime.now();
    // if(chartData.period.year == now.year) {
    //   return (isLast) ? charts.Color.fromHex(code: CustomColors.orange.hex) : charts.Color.fromHex(code: CustomColors.orangeOpacity.hex);
    // }
    return charts.Color.fromHex(code: CustomColors.gray.hex);
  }

  @override
  Widget build(BuildContext context) {
    List<BranchSummary> chartDatalist = widget.chartDatalist;
    List<charts.Series<BranchSummary, String>> series = [
      charts.Series(
        id: widget.id,
        measureFn: (BranchSummary chartData, _) => chartData.value,
        domainFn: (BranchSummary chartData, _) => chartData.place,
        fillColorFn: (BranchSummary chartData, index) => _getColor(chartData, index == chartDatalist.length - 1),
        data: chartDatalist,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
      vertical: widget.isVertical,        
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        showAxisLine: false,
        renderSpec: charts.NoneRenderSpec(),
      ),
      behaviors: [
        charts.ChartTitle(
          widget.title,
          behaviorPosition: charts.BehaviorPosition.top,
          titleOutsideJustification: charts.OutsideJustification.startDrawArea,
          innerPadding: 10
        ),
      ],
    );
  }
}