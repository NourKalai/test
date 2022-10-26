
import 'package:flutter/material.dart';
import 'package:lovester/models/population.dart';
import 'package:lovester/services/countryService.dart';
import 'package:lovester/services/favourites.dart';
import 'package:lovester/widgets/cardWidget.dart';
import 'package:lovester/widgets/chooseCountryWidget.dart';

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

  @override
  Widget build(BuildContext context) {
    final favourite = Favourite.instance;
    return FutureBuilder<List<Population>>(
        future: CountryServices().getPop(x.filterCountry),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: const Color.fromARGB(255, 243, 248, 238),
                appBar: AppBar(
                  elevation: 0,
                  toolbarHeight: 100,
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color.fromARGB(255, 91, 153, 73),
                  title: Container(
                    width: 150.0,
                    height: 110.0,
                    padding: const EdgeInsets.only(right: 3, left: 3),
                    child: TextButton(
                      child: const Text(
                        "Population App",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color.fromARGB(255, 227, 231, 200),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                                  child: CardWidget(
                                    index: index,
                                    snapshot: snapshot,
                                  ));
                            })
                        : GridView.builder(
                            itemCount: favourite.favorites.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height),
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      favourite.favorites[index].country,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                        'population:${favourite.favorites[index].counts[0]
                                                .value}',
                                        style: const TextStyle(fontSize: 18)),
                                    const SizedBox(height: 10),
                                    Text(
                                        'year:${favourite.favorites[index].counts[0]
                                                .year}',
                                        style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                              );
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

Icon iconWidget(IconData data) {
  return Icon(data, size: 30, color: Colors.white);
}
