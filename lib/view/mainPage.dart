import 'package:flutter/material.dart';
import 'package:smile_fokus_test/commons/ChartSection.dart';
import 'package:smile_fokus_test/commons/CustomAppbar.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/component/charts/OverviewChart.dart';
import 'package:smile_fokus_test/component/charts/PerformanceChart.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/component/Breadcrumb.dart';
import 'package:smile_fokus_test/component/OverviewSection.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/MainModel.dart';
import 'package:smile_fokus_test/model/SectionData.dart';
import 'package:smile_fokus_test/model/chart/BranchSummaryChartModel.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';
import 'package:smile_fokus_test/presenter/mainPresenter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smile_fokus_test/view/totalPage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final MainPresenter presenter = MainPresenter();
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainChartResponse revenueData;
  MainChartResponse memberData;
  @override
  void initState() {
    super.initState();
    setup();
    setupChart();
  }

  setup() {
    widget.presenter.view = widget;
  }

  setupChart() {
    revenueData = widget.presenter.getChartData(DataType.revenue);
    memberData = widget.presenter.getChartData(DataType.member);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appBar,
      body: Center(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Breadcrumb(parentContext: context,),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OverviewSection(
                          sectionData: SectionData(
                            title: "Revenue",
                            type: "Corporate",
                            currency: "(THB)",
                            dataOfCurrentYear: revenueData.totalCurrentYear,
                            totalData: revenueData.total,
                          ),
                        ),
                        FlexCard(
                          flex: 4,
                          child: ChartSection<OverviewChartModel>(
                            currency: "THB",
                            isShowRightPanel: true,
                            onTap: () => 
                              Navigator.pushNamed(context, '/Total_Revenue', arguments: revenueData.datalist),
                            customChart: OverviewChart(
                              chartDatalist: revenueData.datalist,
                              domainFn:  (OverviewChartModel data, _) => data.period.toString(),
                              measureFn: (OverviewChartModel data, _) => data.mainAmount.active,
                              id: 'Revenue',
                              title: 'Revenue(THB)',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OverviewSection(
                          sectionData: SectionData(
                            title: "Member",
                            type: "Corporate",
                            currency: "",
                            dataOfCurrentYear: memberData.totalCurrentYear,
                            totalData: memberData.total,
                          ),
                        ),
                        FlexCard(
                          flex: 4,
                          child: ChartSection<OverviewChartModel>(
                            isShowRightPanel: true,
                            onTap: () => 
                              Navigator.pushNamed(context, '/Total_Member', arguments: memberData.datalist),
                            customChart: OverviewChart(
                              chartDatalist: memberData.datalist,
                              domainFn:  (OverviewChartModel data, _) => data.period.toString(),
                              measureFn: (OverviewChartModel data, _) => data.mainAmount.active,
                              id: 'Member',
                              title: 'Member',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OverviewSection(
                          sectionData: SectionData(
                            title: "Branch",
                            type: "Performance",
                            currency: "THB",
                            dataOfCurrentYear: null,
                            totalData: null,
                          ),
                        ),
                        FlexCard(
                          flex: 2,
                          child: ChartSection<BranchSummary>(
                            customChart: PerformanceChart(
                              chartDatalist: revenueData.branchSummaryList,
                              domainFn:  (BranchSummary data, _) => data.place,
                              measureFn: (BranchSummary data, _) => data.value,
                              isVertical: false,
                              title: "Revenue (THB)",
                            ),
                            flex: 2,
                          ),
                        ),
                        FlexCard(
                          flex: 2,
                          child: ChartSection<BranchSummary>(
                            customChart: PerformanceChart(
                              chartDatalist: memberData.branchSummaryList,
                              domainFn:  (BranchSummary data, _) => data.place,
                              measureFn: (BranchSummary data, _) => data.value,
                              isVertical: false,
                              title: "Member",
                            ),
                            flex: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
