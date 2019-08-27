import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/component/charts/CustomChart.dart';
import 'package:smile_fokus_test/model/ChartData.dart';

class ChartSection<T> extends StatelessWidget {
  ChartSection({Key key, 
                this.chartDatalist, 
                this.domainFn, 
                this.measureFn, 
                this.isVertical = true, 
                this.id, 
                this.flex = 4,
                this.title}) : super(key: key);
  final List<T> chartDatalist;
  final dynamic Function(T, int) domainFn;
  final num Function(T, int) measureFn;
  final String id;
  final bool isVertical;
  final String title;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return FlexCard(
      flex: flex,
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