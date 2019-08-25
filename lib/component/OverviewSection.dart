import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smile_fokus_test/commons/Color.dart';
import 'package:smile_fokus_test/component/FlexCard.dart';
import 'package:smile_fokus_test/model/SectionData.dart';

class OverviewSection extends StatelessWidget {
  OverviewSection({this.sectionData});
  SectionData sectionData;
  final formatter = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    var currentYear = new DateTime.now().year;
    return Expanded(
      flex: 1,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlexCard(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    sectionData.title.toUpperCase(), 
                    style: TextStyle(
                      fontFamily: 'Myriad Pro',
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    sectionData.type,
                    style: TextStyle(
                      fontFamily: 'Myriad Pro',
                      color: CustomColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    formatter.format(sectionData.dataOfCurrentYear),
                    style: TextStyle(
                      fontFamily: 'Myriad Pro',
                      color: CustomColors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "$currentYear ${sectionData.title} (${sectionData.currency})",
                    style: TextStyle(
                      fontFamily: 'Myriad Pro',
                      color: CustomColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    formatter.format(sectionData.totalData),
                    style: TextStyle(
                      fontFamily: 'Myriad Pro',
                      color: CustomColors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Total ${sectionData.title} ${sectionData.currency}",
                    style: TextStyle(
                      fontFamily: 'Myriad Pro',
                      color: CustomColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // child: Container(
      //   color: Colors.yellow,
      //   child: Column(
      //     children: <Widget>[
      //       FlexCard(
      //         flex: 1,
      //         child: Container(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Text(
      //                 sectionData.title.toUpperCase(), 
      //                 style: TextStyle(
      //                   fontFamily: 'Myriad Pro',
      //                   color: CustomColors.black,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 30,
      //                 ),
      //               ),
      //               Text(
      //                 sectionData.type,
      //                 style: TextStyle(
      //                   fontFamily: 'Myriad Pro',
      //                   color: CustomColors.black,
      //                   fontWeight: FontWeight.normal,
      //                   fontSize: 20,
      //                 ),
      //               ),
      //               Text(
      //                 formatter.format(sectionData.dataOfCurrentYear),
      //                 style: TextStyle(
      //                   fontFamily: 'Myriad Pro',
      //                   color: CustomColors.orange,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 30,
      //                 ),
      //               ),
      //               Text(
      //                 "$currentYear ${sectionData.title} (${sectionData.currency})",
      //                 style: TextStyle(
      //                   fontFamily: 'Myriad Pro',
      //                   color: CustomColors.black,
      //                   fontWeight: FontWeight.normal,
      //                   fontSize: 15,
      //                 ),
      //               ),
      //               Text(
      //                 sectionData.totalData.toString(),
      //                 style: TextStyle(
      //                   fontFamily: 'Myriad Pro',
      //                   color: CustomColors.orange,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 30,
      //                 ),
      //               ),
      //               Text(
      //                 "Total ${sectionData.title} ${sectionData.currency}",
      //                 style: TextStyle(
      //                   fontFamily: 'Myriad Pro',
      //                   color: CustomColors.black,
      //                   fontWeight: FontWeight.normal,
      //                   fontSize: 15,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           padding: EdgeInsets.all(20),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}