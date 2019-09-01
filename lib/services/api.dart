import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile_fokus_test/constant/constants.dart';
import 'package:smile_fokus_test/constant/enums.dart';

class Api {
  static Map<String, dynamic> getData(DataType type, DisplayType displayType) {
    var response;
    switch (type) {
      case DataType.revenue:
        response = (displayType == DisplayType.month) 
                          ? Constants.revenueMonth 
                          : Constants.revenueDay;
        break;
      case DataType.member:
        response = (displayType == DisplayType.month)
                          ? Constants.memberMonth
                          : Constants.memberDay;
        break;
    }
    return response; 
  }
}