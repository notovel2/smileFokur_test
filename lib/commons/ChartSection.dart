import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/component/charts/CustomChart.dart';

class ChartSection<T> extends StatelessWidget {
  ChartSection({Key key, 
                this.flex = 4,
                this.customChart}) : super(key: key);
  final int flex;
  CustomChart customChart;
  @override
  Widget build(BuildContext context) {
    return FlexCard(
      flex: flex,
      child: customChart,
    );
  }
}