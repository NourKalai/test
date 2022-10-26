import 'dart:convert';

import 'package:lovester/models/population.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourite {
  List<Population> favorites = [];
  Favourite._();
  static Favourite instance = Favourite._();
  void add(Population p) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!favorites.contains(p)) favorites.add(p);
    final String encodedData =
        json.encode(favorites.map((e) => Population.toMap(e)).toList());
    await prefs.setString('favorite_key', encodedData);
  }
}
