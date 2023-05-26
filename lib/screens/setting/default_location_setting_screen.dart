import 'package:flutter/material.dart';
import 'package:weather_app/values/app_styles.dart';

class DefaultLocationSettingScreen extends StatelessWidget {
  const DefaultLocationSettingScreen({Key? key}) : super(key: key);

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
                      child: Text('Default Location Settings',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    )),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CurrentLocationView(),
                    Container(
                      color: Colors.grey,
                      height: 0.25,
                    ),
                  ],
                ))));
  }
}

class CurrentLocationView extends StatelessWidget {
  const CurrentLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              Container(
                width: 5,
              ),
              Text(
                'Current Location',
                style: AppStyles.h4.copyWith(color: Colors.white),
              ),
            ],
          ),
          const Icon(
            Icons.check,
            color: Colors.redAccent,
          )
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
