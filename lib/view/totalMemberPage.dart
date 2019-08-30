import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';
import 'package:smile_fokus_test/view/totalPage.dart';

class TotalMemberPage extends StatefulWidget {

  List<OverviewChartModel> chartdatalist;

  @override
  _TotalMemberPageState createState() => _TotalMemberPageState();
}

class _TotalMemberPageState extends State<TotalMemberPage> {
  @override
  Widget build(BuildContext context) {
    widget.chartdatalist = ModalRoute.of(context).settings.arguments;
    return TotalPage(
      title: "Member",
      chartdatalist: widget.chartdatalist,
    );
  }
}