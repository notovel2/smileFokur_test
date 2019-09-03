import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/constant/Metrics.dart';

class FlexCard extends StatelessWidget {
  FlexCard({this.child, this.flex});
  final int flex;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        child: Card(
          child: Container(
            padding: Metrics.cardMargin,
            child: child
          ),
        ),          
      ),
    );
  }
}