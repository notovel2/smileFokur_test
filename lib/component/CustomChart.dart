import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/model/ChartData.dart';

class CustomChart extends StatefulWidget {
  CustomChart({Key key, this.chartData, this.domainFn, this.measureFn, this.isVertical = true, this.id}) : super(key: key);
  List<ChartData> chartData;
  final dynamic Function(ChartData, int) domainFn;
  final num Function(ChartData, int) measureFn;
  final String id;
  final bool isVertical;
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<CustomChart> {
  
  @override
  Widget build(BuildContext context) {
    List<Series<ChartData, String>> series = [
      Series(
        id: widget.id,
        // measureFn: widget.measureFn,
        // domainFn: widget.domainFn,
        measureFn: (ChartData data, _) => data.mainAmount.active,
        domainFn: (ChartData data, _) => '',
        data: widget.chartData,
      )
    ];
    return FlexCard(
      flex: 3,
      child: BarChart(
        series,
        animate: true,
        vertical: widget.isVertical,
      ),
    );
  }
}