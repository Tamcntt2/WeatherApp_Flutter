import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/screens/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            child: const MaterialApp(
              home: HomeScreen(),
              debugShowCheckedModeBanner: false,
            )));
  }
}
