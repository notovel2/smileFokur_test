import 'package:flutter/widgets.dart';
import 'package:smile_fokus_test/commons/Color.dart';

class Breadcrumb extends StatelessWidget {
  static final pathStack = new List();

  Text _getPathText(String text, bool isLast) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Myriad Pro',
        fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
        fontSize: isLast ? 30 : 20,
        color: isLast ? CustomColors.orange : CustomColors.black,
      ),
    );
  }

  List<Widget> _getPathWidget(List stack) {
    var pathString = '${Navigator.defaultRouteName}Business Insight/Corporate Performance';
    var pathWidgets = List<Widget>();
    var pathList = pathString.split('/').where((path) => path.trim() != '').toList();
    debugPrint("'$pathString'");
    print(pathList.length);
    debugPrint(pathList.toString());
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
    debugPrint('widgets ${pathWidgets.toString()}');
    print('length ${pathWidgets.length}');
    return pathWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: _getPathWidget(pathStack),
      ),
    );
  }
}