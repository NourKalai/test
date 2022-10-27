import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lovester/models/population.dart';
import 'package:lovester/services/countryService.dart';
import 'package:lovester/widgets/cardPopulationWidget.dart';
import 'package:lovester/widgets/chooseCountryWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../widgets/dataWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFilter = false;
  bool isFavorite = false;
  bool isPopulation = true;
  String filterCountry = "";
  List<Population> favorites = [];

  setupFav() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringFav = prefs.getString("favorite");
    if (stringFav != null) {
      List favoriteList = jsonDecode(stringFav);
      for (var pop in favoriteList) {
        setState(() {
          favorites.add(Population.fromJson(pop));
        });
      }
    }
  }

  void add(Population p) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!favorites.contains(p)) favorites.add(p);
    final String encodedData =
        json.encode(favorites.map((e) => Population.toMap(e)).toList());
    await prefs.setString('favorite_key', encodedData);
    List items = favorites.map((e) => e.toJson()).toList();
    prefs.setString('favorite', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupFav();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Population>>(
        future: CountryServices().getPopulations(x.filterCountry),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: Config.mainColorLight,
                appBar: AppBar(
                  elevation: 0,
                  toolbarHeight: 100,
                  automaticallyImplyLeading: false,
                  backgroundColor: Config.data[3]["color"],
                  title: Container(
                    width: 150.0,
                    height: 110.0,
                    padding: const EdgeInsets.only(right: 3, left: 3),
                    child: TextButton(
                      child: titleWidget("Population App"),
                      onPressed: () {
                        setState(() {
                          x.filterCountry = "";
                          isPopulation = true;
                          isFavorite = false;
                        });
                      },
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: iconWidget(Icons.favorite),
                      onPressed: () async {
                        setState(() {
                          isFavorite = true;
                          isPopulation = false;
                        });
                      },
                    ),
                    IconButton(
                        icon: iconWidget(Icons.filter_alt),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return const ChooseCountry();
                              }).then((value) => setState(() {
                                isFilter = true;
                                isPopulation = true;
                                isFavorite = false;
                              }));
                        }),
                    IconButton(
                      icon: const Icon(
                        Icons.filter_alt_off,
                      ),
                      onPressed: () {
                        setState(() {
                          x.filterCountry = "";
                          isPopulation = true;
                        });
                      },
                    ),
                  ],
                ),
                body: Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: !isFavorite
                        ? GridView.builder(
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height),
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onLongPress: () async {
                                    setState(() {
                                      add(snapshot.data![index]);
                                    });
                                  },
                                  child: CardPopulationWidget(
                                    index: index,
                                    snapshot: snapshot,
                                  ));
                            })
                        : GridView.builder(
                            itemCount: favorites.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Config.data[index % 5]["color"],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            iconWidget(Icons.favorite_outlined),
                                            titleWidget(
                                              favorites[index].country,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: List.generate(
                                              1,
                                              (position) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            'population:${favorites[index].counts.map((e) => e.value)}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13)),
                                                        Text(
                                                            'year:${favorites[index].counts.map((e) => e.year)}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13)),
                                                      ],
                                                    ),
                                                  )),
                                        ),
                                      ]),
                                    ),
                                  ));
                            })));
          } else {
            return Scaffold(
                body: Container(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green.shade200,
                      ),
                    )));
          }
        });
  }
}
