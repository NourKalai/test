import 'package:flutter/material.dart';
import 'package:lovester/screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/homePage": (context) => HomeScreen(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
