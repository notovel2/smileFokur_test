import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/component/Button.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/component/charts/CustomChart.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/view/totalPage.dart';

class ChartSection<T> extends StatelessWidget {
  ChartSection({Key key, 
                this.flex = 4,
                this.onTap,
                this.isShowRightPanel = false,
                this.customChart}) : super(key: key);
  final int flex;
  final Function onTap;
  final bool isShowRightPanel;
  CustomChart customChart;

  get rightPanel {

    return <Widget>[
      Button(
        title: "More",
        onPress: onTap,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "1.2M THB",
            style: TextStyle(
              color: CustomColors.orange.color,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Text(
            "Jul 2019",
            style: TextStyle(
              color: CustomColors.orange.color,
              fontSize: 15,
            ),
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FlexCard(
      flex: flex,
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: customChart,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: (isShowRightPanel) ? rightPanel : [],
            )
          ),
        ],
      ),
    );
  }
}