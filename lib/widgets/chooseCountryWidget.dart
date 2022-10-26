import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';

import '../models/flag.dart';
import '../services/countryService.dart';

class x {
  static String filterCountry = "";
}

class ChooseCountry extends StatelessWidget {
  const ChooseCountry({Key? key}) : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    String filterCountry = "";

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
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: ((context, index) {
                      return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              key: ValueKey(
                                  snapshot.data!.data[index].name.toString()),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flag.fromString(
                                  snapshot.data!.data[index].iso2.toString(),
                                  height: 20,
                                  width: 20,
                                  replacement: Text('not found'),
                                ),
                                SizedBox(width: 5),
                                TextButton(
                                    onPressed: () {
                                      x.filterCountry = snapshot
                                          .data!.data[index].name
                                          .toString();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      snapshot.data!.data[index].name
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.green),
                                    ))
                              ]));
                    })),
              );
            }
          }),
    );
  }
}
