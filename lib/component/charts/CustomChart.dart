import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/constant/Color.dart';

class CustomChart<T> extends StatefulWidget{
  CustomChart({Key key, 
                this.chartDatalist, 
                this.domainFn, 
                this.measureFn, 
                this.isVertical = true, 
                this.id, 
                this.title}) : super();
  List<T> chartDatalist;
  dynamic Function(T, int) domainFn;
  num Function(T, int) measureFn;
  String id;
  bool isVertical;
  String title;
  Function callback;

  @override
  State<StatefulWidget> createState() => null;
}