import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/constant/Color.dart';

class Breadcrumb extends StatelessWidget {
  Breadcrumb({
    this.parentContext,
    this.additionalTitle
  });
  static final pathStack = new List();
  final BuildContext parentContext;
  final String additionalTitle;
  final tmpPathList = [
      "Business Insight",
      "Corporate Performance"
  ];
  Widget _getPathText(String text, bool isLast) {
    return Container(
      child: GestureDetector(
        onTap: (){
          if(tmpPathList.contains(text)) {
            Navigator.pop(parentContext);
          } else {
            Navigator.popUntil(parentContext, 
                                 ModalRoute.withName("/$text"));
          }
        },
        child: Text(
          "${text.replaceAll("_", " ")}",
          style: TextStyle(
            fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
            fontSize: isLast ? 30 : 20,
            color: isLast ? CustomColors.orange.color : CustomColors.black.color,
          ),
        ),
      ),
    );
  }

  List<Widget> _getPathWidget(List stack, BuildContext context) {
    var pathWidgets = List<Widget>();
    var pathList = tmpPathList;
    final String pathString = ModalRoute.of(context)
                                .settings
                                .name
                                .replaceFirst('/', '')
                                .trim();
    if(pathString != "") {
      pathList.addAll(pathString.split('/'));
    }
    pathWidgets.add(new Image.asset('assets/home_icon.png'));
    var mappedPath = pathList.asMap()
                              .map((index, path) => 
                                MapEntry(
                                  index, 
                                  Row(
                                    children: <Widget>[
                                      Text("   /   "),
                                      _getPathText(path, index >= pathList.length - 1),
                                    ],
                                  ),
                                )
                              ).values.toList();
    pathWidgets.addAll(mappedPath);
    return pathWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: _getPathWidget(pathStack, context),
      ),
    );
  }
}