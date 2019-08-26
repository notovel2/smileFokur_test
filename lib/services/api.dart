import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile_fokus_test/constant/constants.dart';
import 'package:smile_fokus_test/constant/enums.dart';
import 'package:smile_fokus_test/model/ChartData.dart';

class Api {
  static List<ChartData> getData(dataType type) {
    print('get');
    switch (type) {
      case dataType.revenue:
        print('revenue');
        var data = Constants.revenue['data'] as List;
        print(data.length);
        print("mapping");
        var mapped = data.map((item) => print(item.toString()));
        print("mapping complete");
        print("mapped" + mapped.toString());
        print(mapped.toList());
        return (Constants.revenue['data'] as List).map((item) => ChartData.fromJson(item)).toList();
      case dataType.member:
        return (Constants.revenue['data'] as List).map((item) => ChartData.fromJson(item)).toList();
    }
    return []; 
  }
}