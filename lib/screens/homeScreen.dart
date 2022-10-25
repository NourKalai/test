import 'dart:ui';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lovester/models/Data.dart';
import 'package:lovester/models/flag.dart';
import 'package:lovester/models/population.dart';
import 'package:lovester/services/countryService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String? selectedCountry;
  bool isFilter = false;
  bool isFavorite = false;
  bool isPopulation = true;
  String filterCountry = "";
  List populations = [];
  List favorites = [];

  Future<List<Dataa>> favor(snapshot, index) async {
    final List<Dataa> finallist = [];
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = await prefs.getStringList('favorites');
    final Map dataa = snapshot.data!.data;
    if (items!.contains(dataa[index].city)) {
      finallist.add(Dataa(
        city: dataa[index].city,
        country: dataa[index].country,
        populationCounts: dataa[index].populationCounts,
      ));
    }
    return finallist;
  }

  @override
  void initState() async {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Population>>(
        future: CountryServices().getPop(filterCountry,),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 1,
                  toolbarHeight: 100,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  title: Container(
                    width: 150.0,
                    height: 110.0,
                    padding: EdgeInsets.only(right: 3, left: 3),
                    child: TextButton(
                      child: Text(
                        "Population App",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          filterCountry = "";
                        });
                      },
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      onPressed: () async {

                        setState(() {
                          isFavorite = true;
                        });
                      },
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.filter_alt,
                        ),
                        onPressed: () {
                          setState(() {
                            isFilter = true;
                          });
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text('choose your country'),
                                  content: FutureBuilder<Country>(
                                      future: CountryServices().getFlags(),
                                      builder: (context, snapshot) {
                                        if (snapshot.data == null) {
                                          return Text("loading");
                                        } else {
                                          return Container(
                                            width: double.maxFinite,
                                            child: ListView.builder(
                                                itemCount:
                                                    snapshot.data!.data.length,
                                                itemBuilder: ((context, index) {
                                                  return Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Row(
                                                          key: ValueKey(snapshot
                                                              .data!
                                                              .data[index]
                                                              .name
                                                              .toString()),
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flag.fromString(
                                                              snapshot
                                                                  .data!
                                                                  .data[index]
                                                                  .iso2
                                                                  .toString(),
                                                              height: 20,
                                                              width: 20,
                                                              replacement: Text(
                                                                  'not found'),
                                                            ),
                                                            SizedBox(width: 5),
                                                            TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    filterCountry = snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .name
                                                                        .toString();
                                                                    // print(
                                                                    //     filterCountry);
                                                                  });
                                                                },
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ))
                                                          ]));
                                                })),
                                          );
                                        }
                                      }),
                                );
                              });
                        }),
                    IconButton(
                      icon: Icon(
                        Icons.filter_alt_off,
                      ),
                      onPressed: () {
                        setState(() {
                          filterCountry = "";
                        });
                      },
                    ),
                  ],
                ),
                body: Container(
                    padding: const EdgeInsets.all(5),
                    child: GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          if (isPopulation == true) {
                            return GestureDetector(
                              onLongPress: () async {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          snapshot.data![index].country,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      children: List.generate(
                                          1,
                                          (position) => Column(
                                                children: [
                                                  Text(
                                                      'population:${snapshot.data![index].counts.map((e) => e.value)}',
                                                      style: const TextStyle(
                                                          fontSize: 18)),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                      'year:${snapshot.data![index].counts.map((e) => e.year)}',
                                                      style: const TextStyle(
                                                          fontSize: 18)),
                                                ],
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (isFavorite == true) {
                            return GestureDetector(
                              onLongPress: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final List<String>? items =
                                    await prefs.getStringList('favorites');
                                items == null
                                    ? await prefs.setStringList(
                                        'favorites', [favorites[index].city])
                                    : items.add(favorites[index].city);
                                await prefs.setStringList('favorites', items!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          favorites[index].country,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                        'population:' +
                                            favorites[index]
                                                .populationCounts[0]
                                                .value
                                                .toString(),
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(height: 10),
                                    Text(
                                        'year:' +
                                            favorites[index]
                                                .populationCounts[0]
                                                .year,
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                            );
                          } else
                            return Text("Nothing ");
                        })));
          } else {
            return Text("Loading...");
          }
        });
  }
}
