import 'dart:ui';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lovester/main.dart';
import 'package:lovester/models/Data.dart';
import 'package:lovester/models/flag.dart';
import 'package:lovester/models/population.dart';
import 'package:lovester/services/countryService.dart';
import 'package:lovester/services/favourites.dart';
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
  int id = 0;

  @override
  void initState() {
    String filterCountry = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favourite = Favourite.instance;
    return FutureBuilder<List<Population>>(
        future: CountryServices().getPop(filterCountry),
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
                          isPopulation = true;
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
                          isPopulation = false;
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
                            isPopulation = true;
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
                          isPopulation = true;
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
                              onLongPress: () async {
                                setState(() {
                                  Favourite.instance.add(snapshot.data![index]);
                                });
                              },
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
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: GridView.builder(
                                  itemCount: favourite.favourites.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height),
                                  ),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Text(
                                          favourite.favourites[index].country,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                            'population:' +
                                                favourite.favourites[index]
                                                    .counts[0].value
                                                    .toString(),
                                            style: TextStyle(fontSize: 18)),
                                        SizedBox(height: 10),
                                        Text(
                                            'year:' +
                                                favourite.favourites[index]
                                                    .counts[0].year,
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    );
                                  }),
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
