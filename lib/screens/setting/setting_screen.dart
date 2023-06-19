import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app/screens/setting/default_location_setting_screen.dart';
import 'package:weather_app/screens/setting/notification_setting_screen.dart';
import 'package:weather_app/utils/ui_utils.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';
import 'dart:math';

import '../../bloc/weather_bloc/weather_state.dart';
import '../home/home_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey,
                height: 0.25,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                              create: (BuildContext context) {
                                WeatherBloc weatherBloc = WeatherBloc();
                                return weatherBloc
                                  ..add(WeatherCurrentFetched());
                              },
                              child: BlocListener<WeatherBloc, WeatherState>(
                                  listener: (context, state) {
                                    if (state is WeatherError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(state.message!)));
                                    }
                                  },
                                  child: const HomeScreen()))),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 17,
                )),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.transparent,
                  size: 17,
                ),
                onPressed: () {},
              )
            ],
            title: const Center(
              child: Text('Settings',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            )),
        body: Column(
          children: [
            UnitSetting(),
            Container(
              color: Colors.grey,
              height: 0.25,
            ),
            const NotificationSetting(),
            Container(
              color: Colors.grey,
              height: 0.25,
            ),
            const LocationSetting(),
            Container(
              color: Colors.grey,
              height: 0.25,
            ),
            const LocationDefaultSetting(),
            Container(
              color: Colors.grey,
              height: 0.25,
            ),
          ],
        ),
      ),
    ));
  }
}

class UnitSetting extends StatefulWidget {
  @override
  State<UnitSetting> createState() => _UnitSettingState();
}

class _UnitSettingState extends State<UnitSetting> {
  int? indexDegree;
  int? indexSpeed;
  int? indexDistance;

  Future<void> setDegreeSP(int degree) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('degree', degree);
    await getDegreeSP();
  }

  Future<void> getDegreeSP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      indexDegree = prefs.getInt('degree') ?? 0;
    });
  }

  Future<void> setSpeedSP(int degree) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('speed', degree);
    await getSpeedSP();
  }

  Future<void> getSpeedSP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      indexSpeed = prefs.getInt('speed') ?? 0;
    });
  }

  Future<void> setDistanceSP(int degree) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('distance', degree);
    await getDistanceSP();
  }

  Future<void> getDistanceSP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      indexDistance = prefs.getInt('distance') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    getDistanceSP();
    getSpeedSP();
    getDegreeSP();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Unit',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: ToggleSwitch(
              cornerRadius: 20.0,
              fontSize: 12,
              minHeight: 30,
              minWidth: (UIUtils.getScreenSize(context).width - 45) / 3,
              inactiveFgColor: Colors.white,
              dividerColor: Colors.white,
              initialLabelIndex: indexDegree,
              // activeFgColor: Colors.red,
              inactiveBgColor: Colors.white38,
              activeBgColors: const [
                [Colors.black38],
                [Colors.black38],
                [Colors.black38]
              ],
              doubleTapDisable: true,
              totalSwitches: 3,
              labels: const ['Celsius', 'Fahrenheit', 'Kelvin'],
              onToggle: (index) {
                setState(() {
                  setDegreeSP(index!);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Speed',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: ToggleSwitch(
              minWidth: (UIUtils.getScreenSize(context).width - 45) / 3,
              cornerRadius: 20.0,
              fontSize: 12,
              minHeight: 30,
              inactiveFgColor: Colors.white,
              dividerColor: Colors.white,
              initialLabelIndex: indexSpeed,
              // activeFgColor: Colors.red,
              inactiveBgColor: Colors.white38,
              activeBgColors: const [
                [Colors.black38],
                [Colors.black38],
                [Colors.black38]
              ],
              doubleTapDisable: true,
              totalSwitches: 3,
              labels: const ['m/s', 'km/h', 'mph'],
              onToggle: (index) {
                setState(() {
                  setSpeedSP(index!);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Distance',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: ToggleSwitch(
              minWidth: (UIUtils.getScreenSize(context).width - 45) / 2,
              cornerRadius: 20.0,
              fontSize: 12,
              minHeight: 30,
              inactiveFgColor: Colors.white,
              dividerColor: Colors.white,
              initialLabelIndex: indexDistance,
              // activeFgColor: Colors.red,
              inactiveBgColor: Colors.white38,
              activeBgColors: const [
                [Colors.black38],
                [Colors.black38],
              ],
              doubleTapDisable: true,
              totalSwitches: 2,
              labels: const ['m', 'km'],
              onToggle: (index) {
                setState(() {
                  setDistanceSP(index!);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LocationSetting extends StatefulWidget {
  const LocationSetting({Key? key}) : super(key: key);

  @override
  State<LocationSetting> createState() => _LocationSettingState();
}

class _LocationSettingState extends State<LocationSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Location access',
            style: AppStyles.h4.copyWith(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Always allow',
                style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key}) : super(key: key);

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationSettingScreen(),
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Notification management',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationSettingScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}

class LocationDefaultSetting extends StatefulWidget {
  const LocationDefaultSetting({Key? key}) : super(key: key);

  @override
  State<LocationDefaultSetting> createState() => _LocationDefaultSettingState();
}

class _LocationDefaultSettingState extends State<LocationDefaultSetting> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DefaultLocationSettingScreen(),
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Default location',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Current location',
                  style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DefaultLocationSettingScreen(),
                          ));
                    },
                    icon: const Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
