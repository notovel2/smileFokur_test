import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({Key key, this.title, this.onPress}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15
          ),
        ),
      );
  }
  String title;
  final Function onPress;
}