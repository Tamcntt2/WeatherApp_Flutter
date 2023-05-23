import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/screens/home/temperature_page.dart';
import 'package:weather_app/screens/home/humidity_page.dart';
import 'package:weather_app/screens/home/radar_page.dart';
import 'package:weather_app/screens/home/today_page.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:weather_app/utils/current_location.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/ui_utils.dart';

import '../drawer/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    _scheduleDailyNotification();
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
              title: Center(
                  child: FutureBuilder(
                builder: (context, snapshot) {
                  String textAddress;
                  if (snapshot.hasData) {
                    textAddress =
                        '${snapshot.data!.address!.city}, ${snapshot.data!.address!.country}';
                  } else {
                    textAddress = '';
                  }
                  return Text(
                    UIUtils.convertNameCity(textAddress),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  );
                },
                future: _fetchCurrentAddress(),
              )),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: Icon(Icons.more_vert, size: 24),
                  onPressed: () {
                    _scheduleDailyNotification();
                  },
                ),
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
                    text: 'Humidity',
                  ),
                  Tab(
                    text: 'Radar',
                  ),
                ],
              ),
            ),
            drawer: const Drawer(
              child: MyDrawer(),
            ),
            body: TabBarView(children: [
              // RadarPage(),
              TodayPage(),
              TemperaturePage(),
              HumidityPage(),
              RadarPage()
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> _scheduleDailyNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await _requestPermissions();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Daily Notification Title',
      'Daily Notification Body',
      _nextInstanceOfEightAM(),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              importance: Importance.high, priority: Priority.high)),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'Custom_Sound',
    );
  }

  tz.TZDateTime _nextInstanceOfEightAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, now.hour, now.minute + 1);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
    await Permission.notification.request();
  }

  Future<MyLocation> _fetchCurrentAddress() async {
    Position position = await CurrentLocation.getCurrentLocation();
    double lat = position.latitude;
    double lon = position.longitude;
    print('lat: $lat, lon: $lon');
    var recipesUrl = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon');
    final response = await http.get(recipesUrl);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return MyLocation.fromJson(body);
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
