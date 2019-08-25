import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key key, this.title, this.onPress}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPress,
        child: Text(title),
      );
  }
  String title;
  final Function onPress;
}