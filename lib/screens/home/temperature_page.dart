import 'package:flutter/material.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:weather_app/widgets/my_candle_chart.dart';

import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_state.dart';
import '../../models/forecast.dart';
import '../../widgets/next_day_details_forecast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemperaturePage extends StatelessWidget {
  late Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherInitial || state is WeatherLoading) {
        return BuildLoading();
      } else if (state is WeatherLoaded) {
        forecast = state.forecast!;
        return TemperatureView(forecast: forecast);
      } else {
        return Container();
      }
    });
  }
}

class TemperatureView extends StatelessWidget {
  Forecast forecast;
  bool _isOverview = false;

  TemperatureView({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Temperature',
            style: AppStyles.h3
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 20,
          ),
          TemperatureChart(forecast: forecast),
          Container(
            height: 20,
          ),
          Text(
            'Temperature',
            style: AppStyles.h3
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 20,
          ),
          NextDayDetailsForecast(forecast: forecast),
        ]),
      ),
    );
  }
}

class BuildLoading extends StatelessWidget {
  const BuildLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class TemperatureChart extends StatelessWidget {
  Forecast forecast;

  TemperatureChart({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 35),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xff232329), Color(0xff2F313A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(10)),
        child: MyCandleChart(forecast: forecast));
  }
}
