import 'package:flutter/material.dart';
import 'package:lovester/models/population.dart';
import 'package:lovester/services/countryService.dart';
import 'package:lovester/services/favourites.dart';
import 'package:lovester/widgets/cardPopulationWidget.dart';
import 'package:lovester/widgets/cardWidgetFav.dart';
import 'package:lovester/widgets/chooseCountryWidget.dart';

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

  @override
  Widget build(BuildContext context) {
    final favourite = Favourite.instance;
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
                                      Favourite.instance
                                          .add(snapshot.data![index]);
                                    });
                                  },
                                  child: CardPopulationWidget(
                                    index: index,
                                    snapshot: snapshot,
                                  ));
                            })
                        : const cardFavWidget()));
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
