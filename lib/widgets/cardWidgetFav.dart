import 'package:flutter/material.dart';
import 'package:lovester/widgets/dataWidget.dart';

import '../config.dart';
import '../services/favourites.dart';

class cardFavWidget extends StatelessWidget {
  const cardFavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favourite = Favourite.instance;

    return GridView.builder(
        itemCount: favourite.favorites.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Config.data[index % 5]["color"],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Row(
                      children: [
                        iconWidget(Icons.favorite_outlined),
                        titleWidget(
                          favourite.favorites[index].country,
                        )
                      ],
                    ),
                    Column(
                      children: List.generate(
                          1,
                          (position) => Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Text(
                                        'population:${favourite.favorites[index].counts.map((e) => e.value)}',
                                        style: const TextStyle(fontSize: 13)),
                                    Text(
                                        'year:${favourite.favorites[index].counts.map((e) => e.year)}',
                                        style: const TextStyle(fontSize: 13)),
                                  ],
                                ),
                              )),
                    ),
                  ]),
                ),
              ));
        });
  }
}
