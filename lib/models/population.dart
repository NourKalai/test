import 'dart:convert';
Population populationFromJson(String str) {
  final jsonData = json.decode(str);
  return Population.fromJson(jsonData);
}

String populationToJson(Population data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
class Population {
  int id;

  final String city;
  final String country;
  bool favorite = false;
  final List<PopulationCounts> counts;

  Population({
    this.id = 0,
    required this.city,
    required this.country,
    required this.counts,
    this.favorite = false,
  });
  factory Population.fromJson(Map<String, dynamic> jsonData) => Population(
        id: jsonData['id'],
        city: jsonData['city'],
        country: jsonData['country'],
        counts: List<PopulationCounts>.from(
            jsonData["counts"].map((x) => PopulationCounts.fromJson(x))),
        favorite: false,
      );

 
  factory Population.fromMap(Map data) {
    return Population(
        id: data['id'],
        city: data['city'],
        country: data['country'],
        favorite: false,
        counts: List.from(data['populationCounts'])
            .map((e) => PopulationCounts.fromMap(e))
            .toList());
  }
    Map<String, dynamic> toJson() => {
    "city": city,
        "country": city,
    "counts": new List<dynamic>.from(counts.map((x) => x.toJson())),
  };
  static Map<String, dynamic> toMap(Population population) => {
        'id': population.id,
        'city': population.city,
        'country': population.country,
        'favorite': population.favorite,
        'counts': population.counts,
      };
  static String encode(List<Population> populations) => json.encode(
        populations
            .map<Map<String, dynamic>>(
                (population) => Population.toMap(population))
            .toList(),
      );

  static List<Population> decode(String populations) =>
      (json.decode(populations) as List<dynamic>)
          .map<Population>((item) => Population.fromJson(item))
          .toList();
}

class PopulationCounts {
  PopulationCounts({
    required this.year,
    required this.value,
  });

  late final String city;
  late final String country;
  final String year;
  String? value;

  factory PopulationCounts.fromMap(Map data) {
    return PopulationCounts(year: data['year'], value: data['value']);
  }

   factory PopulationCounts.fromJson(Map<String, dynamic> jsonData) => PopulationCounts(
        year: jsonData['year'],
        value: jsonData['value'],
      );
        Map<String, dynamic> toJson() => {
    "year": year,
        "value": value,
  };
}
