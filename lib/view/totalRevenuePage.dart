import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';
import 'package:smile_fokus_test/view/totalPage.dart';

class TotalRevenuePage extends StatefulWidget {
  List<OverviewChartModel> chartdatalist;
  @override
  _TotalRevenuePageState createState() => _TotalRevenuePageState();
}

class _TotalRevenuePageState extends State<TotalRevenuePage> {
  @override
  Widget build(BuildContext context) {
    widget.chartdatalist = ModalRoute.of(context).settings.arguments;
    return TotalPage(chartdatalist: widget.chartdatalist,);
  }
  
}