import 'package:flutter/material.dart';

Icon iconWidget(IconData data) {
  return Icon(data, size: 30, color: Colors.white);
}

Text titleWidget(String name) {
  return Text(
    name,
    style: const TextStyle(
      fontSize: 20,
      color: Color.fromARGB(255, 227, 231, 200),
      fontWeight: FontWeight.bold,
    ),
  );
}
