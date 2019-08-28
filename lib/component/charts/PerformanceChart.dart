import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:smile_fokus_test/component/charts/CustomChart.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/model/chart/BranchSummaryChartModel.dart';


class PerformanceChart extends CustomChart<BranchSummary> {
  PerformanceChart({Key key, 
                      this.chartDatalist, 
                      this.domainFn, 
                      this.measureFn, 
                      this.isVertical = true, 
                      this.id, 
                      this.onTap,
                      this.title}) : super(key: key);
  @override
  _PerformanceChartState createState() => _PerformanceChartState();
  
  @override
  Function(charts.SelectionModel) onTap;

  @override
  List<BranchSummary> chartDatalist;

  @override
  dynamic Function(BranchSummary, int) domainFn;

  @override
  String id;

  @override
  bool isVertical;

  @override
  num Function(BranchSummary, int) measureFn;

  @override
  String title;
}

class _PerformanceChartState extends State<PerformanceChart> {
  NumberFormat formatter = NumberFormat.compact(locale: "en_US");
  charts.Color _getColor(BranchSummary chartData, bool isLast) {
    DateTime now = DateTime.now();
    
    return (chartData.color != null) ? 
                    charts.Color.fromHex(code: chartData.color)
                  : charts.Color.fromHex(code: CustomColors.gray.hex);
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
        labelAccessorFn: (BranchSummary chartData, _) => "${formatter.format(chartData.value)} ${chartData.place}",
        
        insideLabelStyleAccessorFn: (BranchSummary chartData, _) => charts.TextStyleSpec(color: charts.Color.fromHex(code: CustomColors.black.hex)),
        outsideLabelStyleAccessorFn: (BranchSummary chartData, _) => charts.TextStyleSpec(color: charts.Color.fromHex(code: CustomColors.black.hex))
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
      vertical: widget.isVertical,  
      barRendererDecorator: charts.BarLabelDecorator<String>(),  
      
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
      selectionModels: [
        charts.SelectionModelConfig(type: charts.SelectionModelType.info,
                                      changedListener: widget.onTap)
      ],
    );
  }
}