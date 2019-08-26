import 'package:flutter/material.dart';
import 'package:smile_fokus_test/commons/Color.dart';
import 'package:smile_fokus_test/component/Breadcrumb.dart';
import 'package:smile_fokus_test/component/CustomChart.dart';
import 'package:smile_fokus_test/component/OverviewSection.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/ChartData.dart';
import 'package:smile_fokus_test/model/SectionData.dart';
import 'package:smile_fokus_test/model/UserProfile.dart';
import 'package:smile_fokus_test/services/api.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Container(
            height: 73.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Image.asset('assets/logo.png'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: new Image.asset('assets/user_image.png'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${UserProfile.shared.firstName} ${UserProfile.shared.lastName}",
                              style: TextStyle(
                                color: CustomColors.orange,
                                fontFamily: 'Myriad Pro',
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              UserProfile.shared.location,
                              style: TextStyle(
                                color: CustomColors.gray,
                                fontFamily: 'Myriad Pro',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: CustomColors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'MENU',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Myriad Pro',
                          ),
                        ),
                        new Image.asset('assets/heart.png'),
                      ],
                    ),
                  ),
                ),
                                    
              ],
            ),
          ),
        ),
        backgroundColor: CustomColors.bgBlack,
      ),
      body: Center(
        child: SafeArea(
          child: Container(
            color: CustomColors.bgGray,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Breadcrumb(),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OverviewSection(
                          sectionData: SectionData(
                            title: "Revenue",
                            type: "Corporate",
                            currency: "THB",
                            dataOfCurrentYear: 19042621,
                            totalData: 32872692,
                          ),
                        ),
                        CustomChart(
                          chartData: Api.getData(dataType.revenue),
                          domainFn:  (ChartData data, _) => "",
                          measureFn: (ChartData data, _) => data.mainAmount.active,
                          id: 'Revenue',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OverviewSection(
                          sectionData: SectionData(
                            title: "Member",
                            type: "Corporate",
                            currency: "THB",
                            dataOfCurrentYear: 12692,
                            totalData: 26195,
                          ),
                        ),
                        CustomChart(
                          chartData: [],
                          domainFn:  (ChartData data, _) => "",
                          measureFn: (ChartData data, _) => data.mainAmount.active,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        OverviewSection(
                          sectionData: SectionData(
                            title: "Branch",
                            type: "Performance",
                            currency: "THB",
                            dataOfCurrentYear: null,
                            totalData: null,
                          ),
                        ),
                        CustomChart(
                          chartData: [],
                          domainFn:  (ChartData data, _) => "",
                          measureFn: (ChartData data, _) => data.mainAmount.active,
                          isVertical: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
