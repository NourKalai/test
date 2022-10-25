import 'package:flutter/material.dart';
import 'package:lovester/screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black))),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
