import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile_fokus_test/constant/constants.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/services/service.dart';

class Api {
  static Future<Map<String, dynamic>> getData(DataType type, DisplayType displayType) async{
    return Future(() async{
      String path = (type == DataType.revenue) ? "revenue" : "member";
      var response = await Service.request(
        path: path,
        body: {
          "displayType": (displayType == DisplayType.month) ? "month": "day",
        },
      );
      return jsonDecode(response.body);
    }); 
  }
}