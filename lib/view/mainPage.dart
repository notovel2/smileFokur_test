import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:smile_fokus_test/commons/ChartSection.dart';
import 'package:smile_fokus_test/commons/CustomAppbar.dart';
import 'package:smile_fokus_test/component/Dropdown.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/component/charts/OverviewChart.dart';
import 'package:smile_fokus_test/component/charts/PerformanceChart.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/component/Breadcrumb.dart';
import 'package:smile_fokus_test/component/OverviewSection.dart';
import 'package:smile_fokus_test/constant/constants.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/DropdownItem.dart';
import 'package:smile_fokus_test/model/MainModel.dart';
import 'package:smile_fokus_test/model/SectionData.dart';
import 'package:smile_fokus_test/model/chart/BranchSummaryChartModel.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';
import 'package:smile_fokus_test/presenter/mainPresenter.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final MainPresenter presenter = MainPresenter();
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<DropdownItem<DisplayType>> dropdownlist = Constants.dropdownItems;
  DropdownItem<DisplayType> _selectedDisplayType;
  bool _isMemberLoading = false;
  bool _isRevenueLoading = false;
  MainChartResponse _revenueData = MainChartResponse(datalist: [], branchSummaryList: []);
  MainChartResponse _memberData = MainChartResponse(datalist: [], branchSummaryList: []);
  @override
  void initState() {
    super.initState();
    setup();
    loadChartData();
  }

  setup() {
    widget.presenter.view = widget;
    _selectedDisplayType = (dropdownlist.length > 0) 
                                ? dropdownlist[0] 
                                : DropdownItem<DisplayType>(
                                  title: "",
                                   value: DisplayType.month);
  }

  setChartData({
    @required MainChartResponse response,
    @required DataType dataType
  }) {
    this.setState(() {
      if(dataType == DataType.revenue){
        _revenueData = response;
        _isRevenueLoading = false;
      } else if(dataType == DataType.member) {
        _memberData = response;
        _isMemberLoading = false;
      }
    });
  }

  loadChartData() {
    _isRevenueLoading = true;
    _isMemberLoading = true;
    widget.presenter.getChartData(DataType.revenue, 
                                  _selectedDisplayType.value,
                                  setChartData);
    widget.presenter.getChartData(DataType.member, 
                                  _selectedDisplayType.value,
                                  setChartData);
  }

  void _onDropdownChanged(dynamic value) {
    DropdownItem<DisplayType> tmp = value as DropdownItem<DisplayType>;
    
    setState(() {
      _selectedDisplayType = tmp;
      loadChartData();                                             
    });
  }

  Widget _buildLoading(BuildContext context) {
    if(_isMemberLoading || _isRevenueLoading) {
      return Center(
        child: Container(
          color: CustomColors.loadingBG.color,
          padding: EdgeInsets.all(20),
          child: Loading(indicator: BallSpinFadeLoaderIndicator(), size: 100.0,),
        ),
      );
    }
    return Container();
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Breadcrumb(
                    parentContext: context,
                  ),
                  Dropdown<DropdownItem<DisplayType>>(
                    dropdownlist: dropdownlist,
                    onChanged: _onDropdownChanged,
                  )                        
                ],
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
                        title: "Revenue",
                        type: "Corporate",
                        currency: "(THB)",
                        dataOfCurrentYear: _revenueData.totalCurrentYear,
                        totalData: _revenueData.total,
                      ),
                    ),
                    FlexCard(
                      flex: 4,
                      child: ChartSection<OverviewChartModel>(
                        currency: "THB",
                        displayType: _selectedDisplayType.value,
                        isShowRightPanel: true,
                        onTap: () => 
                          Navigator.pushNamed(context, 
                                              '/Total_Revenue', 
                                              arguments: {
                                                "datalist": _memberData.datalist,
                                                "displayType": _selectedDisplayType.value
                                              }),
                        customChart: OverviewChart(
                          displayType: _selectedDisplayType.value,
                          chartDatalist: _revenueData.datalist,
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
                        dataOfCurrentYear: _memberData.totalCurrentYear,
                        totalData: _memberData.total,
                      ),
                    ),
                    FlexCard(
                      flex: 4,
                      child: ChartSection<OverviewChartModel>(
                        isShowRightPanel: true,
                        displayType: _selectedDisplayType.value,
                        onTap: () => 
                          Navigator.pushNamed(context, 
                                              '/Total_Member', 
                                              arguments: {
                                                "datalist": _memberData.datalist,
                                                "displayType": _selectedDisplayType.value
                                              }),
                        customChart: OverviewChart(
                          chartDatalist: _memberData.datalist,
                          displayType: _selectedDisplayType.value,
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
                          chartDatalist: _revenueData.branchSummaryList,
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
                          chartDatalist: _memberData.branchSummaryList,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CustomAppbar.appBar,
      body: Stack(
        children: <Widget>[
          _buildBody(context),
          _buildLoading(context)
        ]
      ),
        
    );
  }
}
