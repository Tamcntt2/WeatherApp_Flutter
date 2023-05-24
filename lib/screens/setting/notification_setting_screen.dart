import 'package:flutter/material.dart';
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
                      child: Text('Notification Settings',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    )),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TitleNotification(),
                    Container(
                      color: Colors.grey,
                      height: 0.25,
                    ),
                    WarningNotification(),
                    Container(
                      color: Colors.grey,
                      height: 0.25,
                    ),
                    DailyNotification(),
                    Container(
                      color: Colors.grey,
                      height: 0.25,
                    ),
                  ],
                ))));
  }
}

class TitleNotification extends StatelessWidget {
  const TitleNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10),
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
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Allow push notifications',
                    style: AppStyles.h3.copyWith(color: Colors.white),
                  ),
                  Icon(
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
                'Get daily weather forecast at 8 am',
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
