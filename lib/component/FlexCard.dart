import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlexCard extends StatelessWidget {
  FlexCard({this.child, this.flex, this.onTap});
  final int flex;
  final Widget child;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
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