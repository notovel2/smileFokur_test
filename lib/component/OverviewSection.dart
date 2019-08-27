import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smile_fokus_test/constant/Color.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          sectionData.title.toUpperCase(), 
                          style: TextStyle(
                            fontFamily: 'Myriad Pro',
                            color: CustomColors.black.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          sectionData.type,
                          style: TextStyle(
                            fontFamily: 'Myriad Pro',
                            color: CustomColors.black.color,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _getFooter(sectionData, currentYear),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getFooter(SectionData data, int currentYear) {
    var widgets = List<Widget>();
    if(data.dataOfCurrentYear != null) {
      widgets.addAll([
          Text(
            formatter.format(data.dataOfCurrentYear),
            style: TextStyle(
              fontFamily: 'Myriad Pro',
              color: CustomColors.orange.color,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Text(
            "$currentYear ${data.title} (${data.currency})",
            style: TextStyle(
              fontFamily: 'Myriad Pro',
              color: CustomColors.black.color,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ]
      );
    }
    if(data.totalData != null) {
      widgets.addAll([
        Text(
          formatter.format(sectionData.totalData),
          style: TextStyle(
            fontFamily: 'Myriad Pro',
            color: CustomColors.orange.color,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        Text(
          "Total ${sectionData.title} (${sectionData.currency})",
          style: TextStyle(
            fontFamily: 'Myriad Pro',
            color: CustomColors.black.color,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ]);
    }
    return widgets;
  }
}