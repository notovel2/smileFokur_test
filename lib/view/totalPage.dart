import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/commons/ChartSection.dart';
import 'package:smile_fokus_test/commons/CustomAppbar.dart';
import 'package:smile_fokus_test/component/Breadcrumb.dart';
import 'package:smile_fokus_test/component/charts/OverviewChart.dart';
import 'package:smile_fokus_test/component/charts/SegmentationChart.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/constant/Metrics.dart';
import 'package:smile_fokus_test/constant/Styles.dart';
import 'package:smile_fokus_test/model/Segment.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smile_fokus_test/model/chart/ChartModel.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';
import 'package:smile_fokus_test/presenter/totalPagePresenter.dart';

class TotalPage extends StatefulWidget {
  TotalPage({
    this.title,
    this.chartdatalist
  });
  @override
  _TotalPageState createState() => _TotalPageState();
  final String title;
  final List<OverviewChartModel> chartdatalist;
  final TotalPagePresenter presenter = TotalPagePresenter();
}

class _TotalPageState extends State<TotalPage> {
  @override
  void initState() {
    super.initState();
    widget.presenter.view = widget;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar,
      body: Center(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Breadcrumb(
                  parentContext: context,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints viewportConstraints){
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight
                            ),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _getChartSection(widget.chartdatalist),
                                  _getSegmentationSection(widget.chartdatalist)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _getSegmentationSection(List<OverviewChartModel> datalist) {
    List<Segment> segmentlist = widget.presenter.getSegmentlist(datalist);
    return Container(
      height: 1000,
      child: Card(
        child: Container(
          margin: Metrics.cardMargin,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Segmentation :",
                      style: Styles.headerCard,
                    ),
                    Text("All")
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _getSegmentComponents(segmentlist),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getSegmentComponents(List<Segment> segmentlist) {
    return segmentlist.map((item) {
      return Column(
        children: <Widget>[
          Container(
            child: Text(
              item.title,
              style: TextStyle(
                color: CustomColors.black.color,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     child: charts.BarChart(
          //       [
          //         charts.Series<ChartModel, String>(
          //           data: [],
          //           domainFn: (ChartModel model, _) => model.domain,
          //           measureFn: (ChartModel model, _) => model.measure,
          //           id: 'h',
          //         )
          //       ]
          //     ),
          //     // child: SegmentationChart(
          //     //   chartDatalist: item.datamap.values.toList(),
          //     //   measureFn: (ChartModel data, _) => data.measure,
          //     //   domainFn: (ChartModel data, _) => data.domain,
          //     //   id: item.title,
          //     //   callback: () {},
          //     //   title: "",
          //     // ),
          //   ),
          // )
          
        ],
      );
    }).toList();
  }

  Widget _getChartSection(List<OverviewChartModel> chartDatalist) {
    return Container(
      height: 672,
      child: Card(
        child: Container(
          margin: Metrics.cardMargin,
          child: ChartSection(
            flex: null,
            currency: "THB",
            isShowRightPanel: true,
            isShowMoreBtn: false,
            customChart: OverviewChart(
              chartDatalist: chartDatalist,
              domainFn:  (OverviewChartModel data, _) => data.period.toString(),
              measureFn: (OverviewChartModel data, _) => data.mainAmount.active,
              id: 'Revenue',
              title: "",
              isShowGridline: true,
            ),
          ),
        ),
      ),
    );
  }
    

}

class TotalPageArguments {
  final List<OverviewChartModel> chartData;
  TotalPageArguments({
    this.chartData
  });
}