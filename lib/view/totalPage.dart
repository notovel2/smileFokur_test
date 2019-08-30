import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:smile_fokus_test/commons/ChartSection.dart';
import 'package:smile_fokus_test/commons/CustomAppbar.dart';
import 'package:smile_fokus_test/component/Breadcrumb.dart';
import 'package:smile_fokus_test/component/CircluarButton.dart';
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
    this.chartdatalist,
    this.currency = ""
  });
  @override
  _TotalPageState createState() => _TotalPageState();
  final String title;
  final List<OverviewChartModel> chartdatalist;
  final TotalPagePresenter presenter = TotalPagePresenter();
  final String currency;
  final num maxBarWidth = 55;
}

class _TotalPageState extends State<TotalPage> {
  List<Segment> _segmentlist;
  List<Segment> _currentSegmentlist;
  DateTime _currentPeriod;
  OverviewChartModel _summaryData;
  int _cardHeight = 5;
  @override
  void initState() {
    super.initState();
    widget.presenter.view = widget;
    setState(() {
      _segmentlist = widget.presenter.getSegmentlist( widget.chartdatalist, []);
      _currentSegmentlist = _segmentlist;
      _cardHeight = _getCardHeight(segmentlist: _segmentlist);
    });
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
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Breadcrumb(
                        parentContext: context,
                      ),
                      Row(
                        children: <Widget>[
                          CircularButton(
                            child: Image.asset("assets/filter_icon.png"),
                          ),
                          CircularButton(
                            child: Image.asset("assets/export_icon.png"),
                          ),
                          CircularButton(
                            child: Image.asset("assets/printer_icon.png"),
                          )
                        ],
                      )
                    ],
                  ),
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
                                  _getSegmentationSection(_currentSegmentlist),
                                  _getTableSection(body: [],
                                                    header: [
                                                      [
                                                        "Period",
                                                        "Total ${widget.title} (${widget.currency})",
                                                        "Branch",
                                                      ],
                                                      widget.chartdatalist.first.branches.map<String>((branch) => branch.place).toList()
                                                    ])
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
  
  

  Widget _getSegmentationSection(List<Segment> segmentlist) {
    return Container(
      height: _cardHeight.toDouble(),
      child: Card(
        child: Container(
          margin: Metrics.cardMargin,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Segmentation :",
                        style: Styles.headerCard,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      alignment: Alignment.center,
                      child: Text(
                        widget.presenter.getSegmentationHeader(_currentPeriod, _summaryData, widget.currency),
                        style: Styles.highlightedHeaderCard,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _getSegmentComponents(segmentlist),
                  ),
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
      return Expanded(
        flex: 1,
        child: Container(
          height: _getChartHeight(size: item.datamap.length).toDouble(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: CustomColors.black.color,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: SegmentationChart(
                    chartDatalist: item.datamap.values.toList(),
                    measureFn: (ChartModel data, _) => data.measure,
                    domainFn: (ChartModel data, _) => data.domain,
                    id: item.title,
                    callback: () {},
                    title: "",
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
  }

  _chartCallback(OverviewChartModel model) {
    List<Segment> currentSegmentlist = _segmentlist;
    DateTime currentPeriod;
    if(model != null) {
      currentPeriod = model.period;
      currentSegmentlist = widget.presenter.getSegmentlist(widget.chartdatalist, [model.period]);
    }
    setState(() {
      _currentSegmentlist = currentSegmentlist;
      _currentPeriod = currentPeriod;
      _summaryData = widget.presenter.getSummaryData(widget.chartdatalist, currentPeriod);
      _cardHeight = _getCardHeight(segmentlist: currentSegmentlist);
    });
  }

  List<TableRow> _getTableBody({List<OverviewChartModel> from}) {

  }

  Widget _getTableWidget() {

  }

  List<TableRow> _getTableHeader({List<List<String>> by}) {
    return by.map<TableRow>((headers) =>
      TableRow(
        children: headers.map<TableCell>((header) =>
          TableCell(
            child: Text(
              header,
            ),
          )
        ).toList()
      )
    ).toList();
  }

  Widget _getTableSection({List<OverviewChartModel> body, 
                            List<List<String>> header}) {
    List<TableRow> table = _getTableHeader(by: header);
    // table.addAll(_getTableBody(from: body));
    return Card(
      child: Table(
        children: table,
      ),
    );
  }

  Widget _getChartSection(List<OverviewChartModel> chartDatalist) {
    return Container(
      height: 672,
      child: Card(
        child: Container(
          margin: Metrics.cardMargin,
          child: ChartSection(
            flex: 1,
            currency: widget.currency,
            isShowRightPanel: true,
            isShowMoreBtn: false,
            summaryData: _summaryData,
            customChart: OverviewChart(
              callback: _chartCallback,
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
    
  num _getChartHeight({int size}) {
    return widget.maxBarWidth * size;
  }

  int _getCardHeight({List<Segment> segmentlist, num maxHeight = 400}) {
    num maxSize = segmentlist.fold(0, (cur, next) => (cur > next.datamap.length) ? cur : next.datamap.length);
    return maxSize * widget.maxBarWidth;
  }
}

class TotalPageArguments {
  final List<OverviewChartModel> chartData;
  TotalPageArguments({
    this.chartData
  });
}