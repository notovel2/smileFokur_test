import 'package:flutter/cupertino.dart';
import 'package:smile_fokus_test/component/charts/CustomChart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:smile_fokus_test/model/chart/ChartModel.dart';

class SegmentationChart extends CustomChart<ChartModel> {
  SegmentationChart({
    this.domainFn,
    this.measureFn,
    this.chartDatalist,
    this.id,
    this.callback,
    this.title
  });
  final dynamic Function(ChartModel, int) domainFn;
  final num Function(ChartModel, int) measureFn;
  final String id;
  final String title;
  @override
  Function callback;
  @override
  List<ChartModel> chartDatalist;
  @override
  _SegmentationChartState createState() => _SegmentationChartState();
}

class _SegmentationChartState extends State<SegmentationChart> {
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _getSeries(widget.chartDatalist, 
                  widget.id, 
                  widget.measureFn, 
                  widget.domainFn),
      animate: true,
      vertical: false,
      defaultInteractions: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec()
      ),
      domainAxis: charts.OrdinalAxisSpec(
        showAxisLine: false,
        renderSpec: charts.NoneRenderSpec(),
      ),
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectedBarChanged
        )
      ],
    );
  }

  _onSelectedBarChanged(charts.SelectionModel model){
    print(model);
  }

  List<charts.Series<ChartModel, String>> _getSeries(List<ChartModel> chartDatalist,
                                                    String chartId,
                                                    num Function(ChartModel, int) measureFn,
                                                    dynamic Function(ChartModel, int) domainFn) {
    return [
      charts.Series(
        id: chartId,
        measureFn: measureFn,
        domainFn: domainFn,
        data: chartDatalist,
        fillColorFn: (ChartModel segment, _) => segment.color
      )
    ];
  }
  
}