import 'package:flutter/material.dart';
import 'package:weather_app/screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false,);
  }
}
