import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/component/charts/CustomChart.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';

class OverviewChart extends CustomChart<OverviewChartModel> {
  OverviewChart({Key key, 
                this.chartDatalist, 
                this.domainFn, 
                this.measureFn, 
                this.isVertical = true, 
                this.id, 
                this.displayType = DisplayType.month,
                this.callback,
                this.isShowGridline = false,
                this.title}) : super(key: key);
  final dynamic Function(OverviewChartModel, int) domainFn;
  final num Function(OverviewChartModel, int) measureFn;
  final String id;
  final bool isVertical;
  final String title;
  final DisplayType displayType;
  final bool isShowGridline;
  @override
  Function callback;
  @override
  List<OverviewChartModel> chartDatalist;
  @override
  State<StatefulWidget> createState() => _ChartState();
}

class _ChartState extends State<OverviewChart> {
  DateTime _selectedPeriod;
  OverviewChartModel _latest;
  
  bool _isInPeriod(DateTime period, DateTime latest, DisplayType displayType) {
    switch (displayType) {
      case DisplayType.month:
        return period.year == latest.year;
      case DisplayType.day:
        int currentWeekday = latest.weekday;
        DateTime firstDayOfWeek = latest.add(Duration(days: -(currentWeekday + 1)));
        DateTime lastDayOfWeek = latest.add(Duration(days: (9 - currentWeekday)));
        return period.isAfter(firstDayOfWeek) && period.isBefore(lastDayOfWeek);
    }
    return false;
  }

  charts.Color _getColor(OverviewChartModel chartData, bool isLast) {
    if(_selectedPeriod != null) {
      if(chartData.period == _selectedPeriod) {
        return charts.Color.fromHex(code: CustomColors.orange.hex);
      } 
    } else if(chartData != null && _latest != null) {
      if(_isInPeriod(chartData.period, _latest.period, widget.displayType)) {
        return (isLast) ? charts.Color.fromHex(code: CustomColors.orange.hex) : charts.Color.fromHex(code: CustomColors.orangeOpacity.hex);
      }
    }
    return charts.Color.fromHex(code: CustomColors.gray.hex);
  }
  
  @override
  Widget build(BuildContext context) {
    List<OverviewChartModel> chartDatalist = widget.chartDatalist;
    List<charts.Series<OverviewChartModel, String>> series = [
      charts.Series(
        id: widget.id,
        measureFn: (OverviewChartModel chartData, _) => chartData.mainAmount.active,
        domainFn: (OverviewChartModel chartData, _) => chartData.period.toString(),
        fillColorFn: (OverviewChartModel chartData, index) => _getColor(chartData, index == chartDatalist.length - 1),
        data: chartDatalist,
      )
    ];
    if(widget.chartDatalist.isNotEmpty) {
      _latest = widget.chartDatalist.reduce((cur, next) => (next.period.isAfter(cur.period) ? next : cur));
    }

    return charts.BarChart(
      series,
      animate: true,
      vertical: widget.isVertical,        
      
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: (widget.isShowGridline) ? charts.GridlineRendererSpec() 
                                            : charts.NoneRenderSpec()
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
                                      changedListener: _selectedBarListener)
      ],
      defaultInteractions: true,
    );
  }

  _selectedBarListener(charts.SelectionModel model) {
    var response;
    DateTime selectedPeriod;
    if(widget.callback != null) {
      if (_selectedPeriod == null 
          || model.selectedDatum.first.datum.period != _selectedPeriod ) {
        selectedPeriod = model.selectedDatum.first.datum.period;
        response = model.selectedDatum.first.datum;
      }
      setState(() {
        _selectedPeriod = selectedPeriod;
      });
      widget.callback(response);
    }
  }
}