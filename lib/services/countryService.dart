import 'package:http/http.dart' as http;
import 'package:lovester/models/population.dart';

import 'dart:convert';

import '../models/flag.dart';

class CountryServices {
  Future<Country> getFlags() async {
    {
      var response = await http.get(Uri.parse(
          'https://countriesnow.space/api/v0.1/countries/flag/images'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        return Country.fromJson(data);
      } else {
        return jsonDecode(response.body)["error"];
      }
    }
  }

  Future<List<Population>> getPopulations(String? nameCountry) async {
    var response = await http.get(Uri.parse(
        'https://countriesnow.space/api/v0.1/countries/population/cities'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      List<Population> list =
          List.from(body['data']).map((e) => Population.fromMap(e)).toList();
      if (nameCountry != "") {
        List<Population> dumy =
            list.where((element) => element.country == nameCountry).toList();
        return dumy;
      } else {
        return list;
      }
    } else
      return jsonDecode(response.body)["error"];
  }
}
