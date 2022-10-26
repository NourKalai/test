import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, this.snapshot, this.index}) : super(key: key);
  final snapshot;
  final index;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 125, 196, 115),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(right: 5, left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.people_outline_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  snapshot.data![index].country,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 237, 243, 237)),
                ),
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
