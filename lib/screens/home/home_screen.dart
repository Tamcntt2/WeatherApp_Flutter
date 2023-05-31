import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/screens/home/temperature_page.dart';
import 'package:weather_app/screens/home/humidity_page.dart';
import 'package:weather_app/screens/home/radar_page.dart';
import 'package:weather_app/screens/home/today_page.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:weather_app/utils/ui_utils.dart';

import '../../bloc/weather_bloc/weather_bloc.dart';
import '../../bloc/weather_bloc/weather_state.dart';
import '../drawer/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // _scheduleDailyNotification();
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
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherInitial || state is WeatherLoading) {
                      return Container();
                    } else if (state is WeatherLoaded) {
                      MyLocation myLocation = state.myLocation!;
                      // print(myLocation.toJson());
                      String textAddress =
                          '${myLocation.address!.city}, ${myLocation.address!.country}';
                      return Center(
                        child: Text(
                          UIUtils.convertNameCity(textAddress),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 24),
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
            drawer: Drawer(
              child: MyDrawer(),
            ),
            body: TabBarView(children: [
              // RadarPage(),
              const TodayPage(),
              TemperaturePage(),
              HumidityPage(),
              const RadarPage()
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
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print('${now.minute + 1}');
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
}
