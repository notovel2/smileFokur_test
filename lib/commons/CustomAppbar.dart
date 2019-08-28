import 'package:flutter/material.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/model/UserProfile.dart';

class CustomAppbar{
  static get appBar {
    return AppBar(
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
                                color: CustomColors.orange.color,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              UserProfile.shared.location,
                              style: TextStyle(
                                color: CustomColors.gray.color,
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
                    color: CustomColors.orange.color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'MENU',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
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
        backgroundColor: CustomColors.bgBlack.color,
      );
  }
}