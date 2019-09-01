import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/constant/enums.dart';
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
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    widget.chartdatalist = args["datalist"];
    DisplayType displayType = args["displayType"];
    return TotalPage(
      chartdatalist: widget.chartdatalist,
      currency: "THB",
      title: "Revenue",
      displayType: displayType,
    );
  }
  
}