class Household{
  final int serialNum;
  final String region;
  final String province;
  final String city;
  final String barangay;

  Household({
    this.serialNum,
    this.region,
    this.province,
    this.city,
    this.barangay
  });

  factory Household.fromJSON(Map<String, dynamic> json){
    return Household(
      serialNum: json['serialNum'],
      region: json['region'],
      province: json['province'],
      city: json['city'],
      barangay: json['barangay'],
    );
  }
}