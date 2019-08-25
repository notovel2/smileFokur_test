import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlexCard extends StatelessWidget {
  FlexCard({this.child, this.flex});
  int flex;
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
            ),
          ],
        ),
        margin: EdgeInsets.all(3),
        child: child,
      ),
    );
  }
}