import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:smile_fokus_test/constant/Color.dart';
import 'package:smile_fokus_test/model/UserProfile.dart';
import 'package:smile_fokus_test/view/mainPage.dart';
import 'package:smile_fokus_test/view/totalMemberPage.dart';
import 'package:smile_fokus_test/view/totalRevenuePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserProfile.shared.firstName = "WIPA";
    UserProfile.shared.lastName = "PRAMOJ";
    UserProfile.shared.location = "CENTRAL WORLD";
    FlutterStatusbarManager.setHidden(true, animation: StatusBarAnimation.NONE);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        buttonColor: CustomColors.orange.color,
        scaffoldBackgroundColor: CustomColors.bgGray.color,
        fontFamily: 'Myriad-Pro',
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(title: 'Smile Fokus',),
        '/Total_Revenue': (context) => TotalRevenuePage(),
        '/Total_Member': (context) => TotalMemberPage(),
      }
    );
  }
}