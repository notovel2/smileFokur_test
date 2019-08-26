import 'dart:convert';

import 'package:intl/intl.dart';

class ChartData {
  final DateTime period;
  final _MainAmount mainAmount;
  final _Gender gender;
  final Map<String, int> ageMap;
  final List<_Branch> branches;
  final _Tier tier;
  final _Class classes;
  static DateFormat dateFormatter = new DateFormat("dd-MMM-yyyy", "en_US");
  ChartData({
    this.period,
    this.mainAmount,
    this.gender,
    this.ageMap,
    this.branches,
    this.tier,
    this.classes,
  }) ;

  ChartData.fromJson(Map<String, dynamic> json) 
    : period = dateFormatter.parse(json['period'].toString()),
      mainAmount = _MainAmount.fromJson(json['mainAmount']),
      gender = _Gender.fromJson(json['gender']),
      ageMap = jsonDecode(json['age']),
      branches = [],
      tier = _Tier.fromJson(json['tier']),
      classes = _Class.fromJson(json['class']);
}

class _MainAmount {
  final num active;
  final num total;
  _MainAmount({
    this.active,
    this.total,
  });
  _MainAmount.fromJson(Map<String, dynamic> json) 
    : active = json['active'],
      total = json['total'];
}

class _Gender {
  final int gentleMan;
  final int lady;
  final int other;
  _Gender({
    this.gentleMan,
    this.lady,
    this.other,
  });
  _Gender.fromJson(Map<String, dynamic> json) 
    : gentleMan = json['gentleman'] as num,
      lady = json['lady'] as num,
      other = json['other'] as num;
}

class _Branch {
  final String place;
  final int value;
  _Branch({
    this.place,
    this.value
  });
  _Branch.fromJson(Map<String, dynamic> json)
    : place = json['place'],
      value = json['value'] as num;
}

class _Tier {
  final int starter;
  final int silver;
  final int gold;
  final int platinum;
  _Tier({
    this.starter,
    this.silver,
    this.gold,
    this.platinum,
  });
  
  _Tier.fromJson(Map<String, dynamic> json) 
    : starter = json['starter'] as num,
      silver = json['silver'] as num,
      gold = json['gold'] as num,
      platinum = json['platinum'] as num;
}

class _Class {
  final int handShake;
  final int experience;
  final int belonging;
  final int viral;
  final int neverLeave;
  _Class({
    this.handShake,
    this.experience,
    this.belonging,
    this.viral,
    this.neverLeave,
  });
  _Class.fromJson(Map<String, dynamic> json) 
    : handShake = json['handShake'] as num,
      experience = json['experience'] as num,
      belonging = json['belonging'] as num,
      viral = json['viral'] as num,
      neverLeave = json['never_leave'] as num;
}