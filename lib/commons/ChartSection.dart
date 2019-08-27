import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/component/CustomChart.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/model/ChartData.dart';

class ChartSection extends StatelessWidget {
  ChartSection({Key key, this.chartDatalist, this.domainFn, this.measureFn, this.isVertical = true, this.id, this.title}) : super(key: key);
  final List<ChartData> chartDatalist;
  final dynamic Function(ChartData, int) domainFn;
  final num Function(ChartData, int) measureFn;
  final String id;
  final bool isVertical;
  final String title;
  @override
  Widget build(BuildContext context) {
    return FlexCard(
      flex: 3,
      child: CustomChart(
        id: this.id,
        title: this.title,
        chartDatalist: chartDatalist,
        domainFn:  this.domainFn,
        measureFn: this.measureFn,
        isVertical: this.isVertical,
      ),
    );
  }
}