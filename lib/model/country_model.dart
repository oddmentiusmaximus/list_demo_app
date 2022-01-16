class CountryModel {
  List? data;

  CountryModel.fromJson(Map<String, dynamic> json) {
    Map data1 = json['data']['data'];
    data = data1.entries
        .map((e) => Country.fromJson(
              e.value,
              e.key,
            ))
        .toList();
  }
}

class Country {
  String? key;
  String? country;
  String? region;

  Country({this.key, this.country, this.region,});

  Country.fromJson(Map<String, dynamic> json, String code) {
    country = json['country'];
    region = json['region'];
    key = code;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['country'] = country;
    data['region'] = region;
    return data;
  }
}
