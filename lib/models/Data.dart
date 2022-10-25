import 'package:lovester/models/population.dart';

class Dataa {
  Dataa({
    required this.city,
    required this.country,
    required this.populationCounts,
  });
  late final String city;
  late final String country;
  late final List<PopulationCounts> populationCounts;

  Dataa.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    populationCounts = List.from(json['populationCounts'])
        .map((e) => PopulationCounts.fromMap(e))
        .toList();
  }
  
}