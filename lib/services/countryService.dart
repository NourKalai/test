import 'package:http/http.dart' as http;
import 'package:lovester/models/population.dart';

import 'dart:convert';

import '../models/flag.dart';

class CountryServices {
  Future<Country> getFlags() async {
    var response = await http.get(
        Uri.parse('https://countriesnow.space/api/v0.1/countries/flag/images'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return Country.fromJson(data);
    } else {
      return Country.fromJson(data);
    }
  }

  Future<List<Population>> getPopulations() async {
    var response = await http.get(Uri.parse(
        'https://countriesnow.space/api/v0.1/countries/population/cities'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return List.from(body['data']).map((e) => Population.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<Population>> getPop(String? nameCountry) async {
    var response = await http.get(Uri.parse(
        'https://countriesnow.space/api/v0.1/countries/population/cities'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200 && nameCountry != "") {
      final Map<String, dynamic> body = json.decode(response.body);
      List<Population> list =
          List.from(body['data']).map((e) => Population.fromMap(e)).toList();

      List<Population> dumy =
          list.where((element) => element.country == nameCountry).toList();

      return dumy;
    // } else if ((response.statusCode == 200 && isFavorite)) {
    //   final Map<String, dynamic> body = json.decode(response.body);
    //   List<Population> list =
    //       List.from(body['data']).map((e) => Population.fromMap(e)).toList();
    //   List<Population> dumy =
    //       list.where((element) => favorites!.contains(element.city)).toList();

    //   return dumy;
    } else if (response.statusCode == 200 && nameCountry == "") {
      final Map<String, dynamic> body = json.decode(response.body);
      List<Population> list =
          List.from(body['data']).map((e) => Population.fromMap(e)).toList();
      return list;
    } else {
      return [];
    }
  }

  Future<List<Population>> getFavorites() async {
    var response = await http.get(Uri.parse(
        'https://countriesnow.space/api/v0.1/countries/population/cities'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      List<Population> list =
          List.from(body['data']).map((e) => Population.fromMap(e)).toList();

      List<Population> dumy =
          list.where((element) => element.favorite == true).toList();

      return dumy;
    } else {
      return [];
    }
  }
}
