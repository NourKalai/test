class Population {
  final String city;
  final String country;
    bool favorite=false;


  final List<PopulationCounts> counts;

  Population({
    required this.city,
    required this.country,
    required this.counts,
    this.favorite=false,
  });

  factory Population.fromMap(Map data) {
    return Population(
        city: data['city'],
        country: data['country'],
            favorite:data['favorite'],

        counts: List.from(data['populationCounts'])
            .map((e) => PopulationCounts.fromMap(e))
            .toList());
  }
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
}

