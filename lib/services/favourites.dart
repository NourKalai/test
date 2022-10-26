import 'dart:convert';

import 'package:lovester/models/population.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourite {
  List<Population> favourites = [];

  Favourite._();

  static Favourite instance = Favourite._();

  /// Favourite.instqnce.fqvourites

  void add(Population p) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('favorite_key', "");
    // Encode and store data in SharedPreferences
    if (favourites.contains(p))
      return null;
    else {
      favourites.add(p);
      final String encodedData =
          json.encode(favourites.map((e) => Population.toMap(e)).toList());
      await prefs.setString('favorite_key', encodedData);
    }
  }
}
