import 'package:flutter/material.dart';
import 'package:smile_fokus_test/constant/Color.dart';

class CircularButton extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final Color color;
  const CircularButton({Key key, 
                        this.color,
                        this.onTap, 
                        this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: ClipOval(
          child: Container(
            height: 60,
            width: 60,
            color: this.color ?? CustomColors.orange.color,
            child: Center(
              child: child
            ),
          ),
        ),
      ),
    );
  }
  
}