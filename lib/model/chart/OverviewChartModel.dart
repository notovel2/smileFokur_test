import 'package:intl/intl.dart';

class OverviewChartModel {
  final DateTime period;
  final _MainAmount mainAmount;
  final _Gender gender;
  final List<_Age> agelist;
  final List<_Branch> branches;
  final _Tier tier;
  final _Class classes;
  static DateFormat dateFormatter = new DateFormat("dd-MMM-yyyy", "en_US");
  OverviewChartModel({
    this.period,
    this.mainAmount,
    this.gender,
    this.agelist,
    this.branches,
    this.tier,
    this.classes,
  }) ;

  OverviewChartModel.fromJson(Map<String, dynamic> json) 
    : period = dateFormatter.parse(json['period'].toString()),
      mainAmount = _MainAmount.fromJson(json['mainAmount']),
      gender = _Gender.fromJson(json['gender']),
      agelist = (json['age'] as List).map((age) => _Age.fromJson(age)).toList(),
      branches = (json['branch'] as List).map((branch) => _Branch.fromJson(branch)).toList(),
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
  final num gentleMan;
  final num lady;
  final num other;
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

class _Age {
  _Age({
    this.range,
    this.value
  });
  final String range;
  final num value;
  _Age.fromJson(Map<String, dynamic> json)
    : range = json['range'],
      value = json['value'];
}
class _Branch {
  String place;
  num value;
  _Branch({
    this.place,
    this.value
  });
  // _Branch.fromJson(Map<String, dynamic> json)
  //   : place = json['place'],
  //     value = json['value'] as num;
_Branch.fromJson(Map<String, dynamic> json)
  : place = json['place'],
    value = json['value'] as num;
}

class _Tier {
  final num starter;
  final num silver;
  final num gold;
  final num platinum;
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
  final num handShake;
  final num experience;
  final num belonging;
  final num viral;
  final num neverLeave;
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