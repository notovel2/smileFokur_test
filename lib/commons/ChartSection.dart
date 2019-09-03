import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:smile_fokus_test/component/Button.dart';
import 'package:smile_fokus_test/component/charts/CustomChart.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/chart/OverviewChartModel.dart';

class ChartSection<T> extends StatelessWidget {
  ChartSection({Key key, 
                this.flex = 4,
                this.onTap,
                this.isShowRightPanel = false,
                this.isShowMoreBtn = true,
                this.currency = "",
                this.displayType = DisplayType.month,
                this.summaryData,
                @required this.customChart}) :  _dateFormat = DateFormat((displayType == DisplayType.day) ? "dd MMM yyyy" : "MMM yyyy", "en_US"),
                                                formatter = NumberFormat.compact(locale: "en_US"),
                                                super(key: key);
  final int flex;
  final DisplayType displayType;
  final Function onTap;
  final bool isShowRightPanel;
  final bool isShowMoreBtn;
  final String currency;
  final OverviewChartModel summaryData;
  final CustomChart customChart;
  final DateFormat _dateFormat;
  final NumberFormat formatter;

  _getMoreBtn(bool isShow) {
    return (isShow) ? Button(
        title: "More",
        onPress: onTap,
      ) : Container();
  }

  String _getTotalActive(OverviewChartModel summaryData, List<OverviewChartModel> chartdatalist) {
    if(summaryData != null) {
      return formatter.format(summaryData.mainAmount.active);
    }
    if(chartdatalist.isNotEmpty) {
      return formatter.format(
        chartdatalist.last.mainAmount.active
      );
    }
    return "No data";
    
  }

  DateTime _getPeriod(List<OverviewChartModel> list, OverviewChartModel summary) {
    if(summary != null) {
      return summary.period;
    }
    if(list.isNotEmpty) {
      return list.last.period;
    }
    return null;
  }

  _getRightPanel(List<OverviewChartModel> chartdatalist) {
    DateTime period = _getPeriod(chartdatalist, summaryData);
    return <Widget>[
      _getMoreBtn(isShowMoreBtn),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "${_getTotalActive(summaryData, chartdatalist)} $currency",
              style: TextStyle(
                color: CustomColors.orange.color,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "${(period != null) ? _dateFormat.format(period) : "No data"}",
              style: TextStyle(
                color: CustomColors.orange.color,
                fontSize: 15,
              ),
            ),
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: customChart,
            ),
          ),
          Container(
            width: 100,
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: (isShowRightPanel) ? _getRightPanel(customChart.chartDatalist) : [],
            )
          ),
        ],
    );
  }
}