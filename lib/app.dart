import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/home/home_screen.dart';
import 'package:weather_app/screens/splash/splash_screen.dart';
import 'package:weather_app/screens/stepper/stepper_screen.dart';

import 'bloc/weather_state.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) {
          WeatherBloc weatherBloc = WeatherBloc();
          return weatherBloc..add(WeatherFetched());
        },
        child: BlocListener<WeatherBloc, WeatherState>(
            listener: (context, state) {
              if (state is WeatherError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message!)));
              }
            },
            child: MaterialApp(
              home: FutureBuilder(
                future: fetchSomething(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return StepperScreen();
                  } else if (snapshot.hasData && snapshot.data == false) {
                    return HomeScreen();
                  } else {
                    return SplashScreen();
                  }
                },
              ),
              debugShowCheckedModeBanner: false,
            )));
  }

  Future<bool> fetchSomething() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    await prefs.setBool('isFirstTime', true);
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }
    return isFirstTime;
  }
}
