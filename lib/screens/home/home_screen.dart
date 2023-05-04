import 'package:flutter/material.dart';
import 'package:weather_app/screens/home/temperature_page.dart';
import 'package:weather_app/screens/home/precipitation_page.dart';
import 'package:weather_app/screens/home/radar_page.dart';
import 'package:weather_app/screens/home/today_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff484B5B), Color(0xff2C2D35)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Center(
                  child: Text(
                'Tamil Nadu, Chennai',
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: const [
                Icon(Icons.more_vert, size: 24),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Today',
                  ),
                  Tab(
                    text: 'Temperature',
                  ),
                  Tab(
                    text: 'Precipitation',
                  ),
                  Tab(
                    text: 'Radar',
                  ),
                ],
              ),
            ),
            drawer: const Drawer(
                child: Icon(
              Icons.menu,
              size: 24,
            )),
            body: TabBarView(children: [
              TodayPage(),
              TemperaturePage(),
              PrecipitationPage(),
              RadarPage()
            ]),
          ),
        ),
      ),
    );
  }
}
