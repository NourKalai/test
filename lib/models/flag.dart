class Data {
  Data({
    required this.name,
    required this.flag,
    required this.iso3,
  });
  late final String name;
  late final String flag;
  late final String iso3;
  late final String iso2;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    flag = json['flag'] as String;
    iso3 = json['iso3'] as String;
    iso2 = json['iso2'] as String;
  }
}

class Country {
  Country({
    required this.data,
  });

  late final List<Data> data;

  Country.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }
}
