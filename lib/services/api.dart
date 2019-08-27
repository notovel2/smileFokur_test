import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile_fokus_test/constant/constants.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/ChartData.dart';

class Api {
  static Map<String, dynamic> getData(DataType type) {
    var response;
    switch (type) {
      case DataType.revenue:
        response = Constants.revenue;
        break;
      case DataType.member:
        response = Constants.member;
        break;
    }
    return response; 
  }
}