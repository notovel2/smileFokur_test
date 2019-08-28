import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/commons/CustomAppbar.dart';
import 'package:smile_fokus_test/component/Breadcrumb.dart';

class TotalPage extends StatefulWidget {
  TotalPage({
    this.title
  });
  @override
  _TotalPageState createState() => _TotalPageState();
  final String title;
}

class _TotalPageState extends State<TotalPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppbar.appBar,
      body: Center(
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Breadcrumb(parentContext: context,)
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}