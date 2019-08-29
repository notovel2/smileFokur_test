import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/view/totalPage.dart';

class TotalMemberPage extends StatefulWidget {

  TotalPageArguments args;

  @override
  _TotalMemberPageState createState() => _TotalMemberPageState();
}

class _TotalMemberPageState extends State<TotalMemberPage> {
  @override
  Widget build(BuildContext context) {
    widget.args = ModalRoute.of(context).settings.arguments;
    return TotalPage();
  }
}