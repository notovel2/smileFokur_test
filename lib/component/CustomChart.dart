import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/model/ChartData.dart';

class CustomChart extends StatefulWidget {
  CustomChart({Key key, this.chartDatalist, this.domainFn, this.measureFn, this.isVertical = true, this.id, this.title}) : super(key: key);
  List<ChartData> chartDatalist;
  final dynamic Function(ChartData, int) domainFn;
  final num Function(ChartData, int) measureFn;
  final String id;
  final bool isVertical;
  final String title;
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<CustomChart> {
  
  charts.Color _getColor(ChartData chartData, bool isLast) {
    DateTime now = DateTime.now();
    if(chartData.period.year == now.year) {
      return (isLast) ? charts.Color.fromHex(code: CustomColors.orange.hex) : charts.Color.fromHex(code: CustomColors.orangeOpacity.hex);
    }
    return charts.Color.fromHex(code: CustomColors.gray.hex);
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartDatalist = widget.chartDatalist;
    List<charts.Series<ChartData, String>> series = [
      charts.Series(
        id: widget.id,
        measureFn: (ChartData chartData, _) => chartData.mainAmount.active,
        domainFn: (ChartData chartData, _) => chartData.period.toString(),
        fillColorFn: (ChartData chartData, index) => _getColor(chartData, index == chartDatalist.length - 1),
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