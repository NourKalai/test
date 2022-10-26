import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lovester/models/population.dart';
import 'package:lovester/widgets/dataWidget.dart';

import '../config.dart';

class CardPopulationWidget extends StatelessWidget {
  const CardPopulationWidget({Key? key, this.snapshot, this.index})
      : super(key: key);
  final snapshot;
  final index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Config.data[index + 2 % 10]["color"],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(right: 5, left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconWidget(Icons.people_outline_sharp),
                titleWidget(snapshot.data![index].country),
              ],
            ),
          ),
          Column(
            children: List.generate(
                1,
                (position) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                              'population:${snapshot.data![index].counts.map((e) => e.value)}',
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 10),
                          Text(
                              'year:${snapshot.data![index].counts.map((e) => e.year)}',
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
