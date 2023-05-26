import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weather_app/screens/setting/default_location_setting_screen.dart';
import 'package:weather_app/screens/setting/notification_setting_screen.dart';
import 'package:weather_app/utils/setting_utits.dart';
import 'package:weather_app/utils/ui_utils.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
              child: Container(
                color: Colors.grey,
                height: 0.25,
              ),
              preferredSize: Size.fromHeight(1.0),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 17,
                )),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.transparent,
                  size: 17,
                ),
                onPressed: () {},
              )
            ],
            title: Center(
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
            NotificationSetting(),
            Container(
              color: Colors.grey,
              height: 0.25,
            ),
            LocationSetting(),
            Container(
              color: Colors.grey,
              height: 0.25,
            ),
            LocationDefaultSetting(),
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
  const UnitSetting({Key? key}) : super(key: key);

  @override
  State<UnitSetting> createState() => _UnitSettingState();
}

class _UnitSettingState extends State<UnitSetting> {
  late int _indexDegree;

  late int _indexSpeed;

  late int _indexDistance;

  Future<void> setDegreeSP(int degree) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('degree', degree);
  }

  Future<void> getDegreeSP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _indexDegree = prefs.getInt('degree') ?? 0;
    });
  }

  Future<void> setSpeedSP(int degree) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('speed', degree);
  }

  Future<void> getSpeedSP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _indexSpeed = prefs.getInt('speed') ?? 0;
    });
  }

  Future<void> setDistanceSP(int degree) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('distance', degree);
  }

  Future<void> getDistanceSP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _indexDistance = prefs.getInt('distance') ?? 0;
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
          ToggleSwitch(
            minWidth: UIUtils.getScreenSize(context).width - 40,
            cornerRadius: 20.0,
            fontSize: 12,
            minHeight: 30,
            inactiveFgColor: Colors.white,
            dividerColor: Colors.white,
            initialLabelIndex: _indexDegree,
            // activeFgColor: Colors.red,
            inactiveBgColor: Colors.white38,
            activeBgColors: const [
              [Colors.black38],
              [Colors.black38],
              [Colors.black38]
            ],
            doubleTapDisable: true,
            totalSwitches: 3,
            labels: ['Celsius', 'Fahrenheit', 'Kelvin'],
            onToggle: (index) {
              setState(() {
                setDegreeSP(index!);
                _indexDegree = index!;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Speed',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
          ),
          ToggleSwitch(
            minWidth: UIUtils.getScreenSize(context).width - 40,
            cornerRadius: 20.0,
            fontSize: 12,
            minHeight: 30,
            inactiveFgColor: Colors.white,
            dividerColor: Colors.white,
            initialLabelIndex: _indexSpeed,
            // activeFgColor: Colors.red,
            inactiveBgColor: Colors.white38,
            activeBgColors: const [
              [Colors.black38],
              [Colors.black38],
              [Colors.black38]
            ],
            doubleTapDisable: true,
            totalSwitches: 3,
            labels: ['m/s', 'km/h', 'mph'],
            onToggle: (index) {
              setState(() {
                setSpeedSP(index!);
                _indexSpeed = index!;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Distance',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
          ),
          ToggleSwitch(
            minWidth: UIUtils.getScreenSize(context).width - 40,
            cornerRadius: 20.0,
            fontSize: 12,
            minHeight: 30,
            inactiveFgColor: Colors.white,
            dividerColor: Colors.white,
            initialLabelIndex: _indexDistance,
            // activeFgColor: Colors.red,
            inactiveBgColor: Colors.white38,
            activeBgColors: const [
              [Colors.black38],
              [Colors.black38],
            ],
            doubleTapDisable: true,
            totalSwitches: 2,
            labels: ['m', 'km'],
            onToggle: (index) {
              setState(() {
                setDistanceSP(index!);
                _indexDistance = index!;
              });
            },
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  icon: Icon(
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
              builder: (context) => NotificationSettingScreen(),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                        builder: (context) => NotificationSettingScreen(),
                      ));
                },
                icon: Icon(
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
              builder: (context) => DefaultLocationSettingScreen(),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                                DefaultLocationSettingScreen(),
                          ));
                    },
                    icon: Icon(
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