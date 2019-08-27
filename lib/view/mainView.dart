import 'package:flutter/material.dart';
import 'package:smile_fokus_test/commons/ChartSection.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/component/Breadcrumb.dart';
import 'package:smile_fokus_test/component/OverviewSection.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/ChartData.dart';
import 'package:smile_fokus_test/model/ChartModel.dart';
import 'package:smile_fokus_test/model/SectionData.dart';
import 'package:smile_fokus_test/model/UserProfile.dart';
import 'package:smile_fokus_test/presenter/mainPresenter.dart';
import 'package:smile_fokus_test/services/api.dart';

class MainView extends StatefulWidget {
  MainView({Key key, this.title}) : super(key: key);
  final MainPresenter presenter = MainPresenter();
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ChartModel revenueData;
  ChartModel memberData;
  ChartModel performanceRevenue;
  ChartModel performanceMember;
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
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            height: 73.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Image.asset('assets/logo.png'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: new Image.asset('assets/user_image.png'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${UserProfile.shared.firstName} ${UserProfile.shared.lastName}",
                              style: TextStyle(
                                color: CustomColors.orange.color,
                                fontFamily: 'Myriad Pro',
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              UserProfile.shared.location,
                              style: TextStyle(
                                color: CustomColors.gray.color,
                                fontFamily: 'Myriad Pro',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: CustomColors.orange.color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'MENU',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Myriad Pro',
                          ),
                        ),
                        new Image.asset('assets/heart.png'),
                      ],
                    ),
                  ),
                ),
                                    
              ],
            ),
          ),
        ),
        backgroundColor: CustomColors.bgBlack.color,
      ),
      body: Center(
        child: SafeArea(
          child: Container(
            color: CustomColors.bgGray.color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Breadcrumb(),
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
                            currency: "THB",
                            dataOfCurrentYear: revenueData.totalCurrentYear,
                            totalData: revenueData.total,
                          ),
                        ),
                        ChartSection(
                          chartDatalist: revenueData.datalist,
                          domainFn:  (ChartData data, _) => data.period.toString(),
                          measureFn: (ChartData data, _) => data.mainAmount.active,
                          id: 'Revenue',
                          title: 'Revenue(THB)',
                        ),
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
                            currency: "THB",
                            dataOfCurrentYear: memberData.totalCurrentYear,
                            totalData: memberData.total,
                          ),
                        ),
                        ChartSection(
                          chartDatalist: memberData.datalist,
                          domainFn:  (ChartData data, _) => data.period.toString(),
                          measureFn: (ChartData data, _) => data.mainAmount.active,
                          id: 'Member',
                          title: 'Member(THB)',
                        ),
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
                        ChartSection(
                          chartDatalist: [],
                          domainFn:  (ChartData data, _) => data.period.toString(),
                          measureFn: (ChartData data, _) => data.mainAmount.active,
                          isVertical: false,
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
