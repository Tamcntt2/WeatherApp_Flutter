import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/values/app_styles.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

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
                          Navigator.pop(context);
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
                      child: Text('Notification Settings',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    )),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TitleNotification(),
                    Container(
                      color: Colors.grey,
                      height: 0.25,
                    ),
                    const WarningNotification(),
                    Container(
                      color: Colors.grey,
                      height: 0.25,
                    ),
                    const DailyNotification(),
                    Container(
                      color: Colors.grey,
                      height: 0.25,
                    ),
                    const TimeDailySetting()
                  ],
                ))));
  }
}

class TimeDailySetting extends StatefulWidget {
  const TimeDailySetting({Key? key}) : super(key: key);

  @override
  State<TimeDailySetting> createState() => _TimeDailySettingState();
}

class _TimeDailySettingState extends State<TimeDailySetting> {
  late TimeOfDay timeOfDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily notification time',
                style: AppStyles.h3.copyWith(color: Colors.white),
              ),
              Container(
                height: 5,
              ),
              Text(
                'What time is the daily weather forecast?',
                style: AppStyles.h4.copyWith(color: Colors.white),
              )
            ],
          ),
          FutureBuilder(
            future: fetchTimeSettingDaily(),
            builder: (context, snapshot) {
              timeOfDay = snapshot.data!;
              return TextButton(
                onPressed: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: timeOfDay);
                  if (time == null) return;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setInt('hourDaily', time.hour);
                  await prefs.setInt('minuteDaily', time.minute);
                  setState(() {
                    timeOfDay = time;
                  });
                },
                child: Text(
                  '${timeOfDay.hour > 9 ? timeOfDay.hour : ('0${timeOfDay.hour}')}:${timeOfDay.minute > 9 ? timeOfDay.minute : ('0${timeOfDay.minute}')}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

Future<TimeOfDay> fetchTimeSettingDaily() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int hour = prefs.getInt('hourDaily') ?? 8;
  int minute = prefs.getInt('minuteDaily') ?? 0;
  TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
  return timeOfDay;
}

class TitleNotification extends StatelessWidget {
  const TitleNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Text(
            'Push notifications are turned off!',
            style: AppStyles.h4.copyWith(color: Colors.white),
          ),
          Container(
            height: 3,
          ),
          Text(
            'Go to your device\'s settings to enable push notifications',
            style: AppStyles.h4.copyWith(color: Colors.white),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Allow push notifications',
                    style: AppStyles.h3.copyWith(color: Colors.white),
                  ),
                  const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                    size: 17,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WarningNotification extends StatefulWidget {
  const WarningNotification({super.key});

  @override
  State<WarningNotification> createState() => _WarningNotificationState();
}

class _WarningNotificationState extends State<WarningNotification> {
  bool _checkWarning = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Government warning',
                style: AppStyles.h3.copyWith(color: Colors.white),
              ),
              Container(
                height: 5,
              ),
              Text(
                'Severe weather warnings for selected locations',
                style: AppStyles.h4.copyWith(color: Colors.white),
              )
            ],
          ),
          Switch(
            value: _checkWarning,
            onChanged: (value) {
              setState(() {
                _checkWarning = value;
              });
            },
          )
        ],
      ),
    );
  }
}

class DailyNotification extends StatefulWidget {
  const DailyNotification({Key? key}) : super(key: key);

  @override
  State<DailyNotification> createState() => _DailyNotificationState();
}

class _DailyNotificationState extends State<DailyNotification> {
  bool _checkDaily = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily notification',
                style: AppStyles.h3.copyWith(color: Colors.white),
              ),
              Container(
                height: 5,
              ),
              Text(
                'Get daily weather forecast',
                style: AppStyles.h4.copyWith(color: Colors.white),
              )
            ],
          ),
          Switch(
            value: _checkDaily,
            onChanged: (value) {
              setState(() {
                _checkDaily = value;
              });
            },
          )
        ],
      ),
    );
  }
}
