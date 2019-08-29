class BranchSummary{
  BranchSummary({
    this.place,
    this.value
  });
  String place;
  num value;
  String color;

  BranchSummary.fromJson(Map<String, dynamic> json)
    : place = json['place'],
      value = json['value'];
}