import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:weather_app/widgets/my_column_chart.dart';

import '../../bloc/weather_bloc/weather_bloc.dart';
import '../../bloc/weather_bloc/weather_state.dart';
import '../../models/forecast.dart';
import '../../widgets/next_day_details_forecast.dart';

class HumidityPage extends StatelessWidget {
  late Forecast forecast;
  late int checkDegree;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherInitial || state is WeatherLoading) {
        return BuildLoading();
      } else if (state is WeatherLoaded) {
        forecast = state.forecast!;
        checkDegree = state.checkDegree!;
        return HumidityView(forecast: forecast, checkDegree: checkDegree);
      } else {
        return Container();
      }
    });
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

class HumidityView extends StatelessWidget {
  final Forecast forecast;
  final int checkDegree;

  HumidityView({required this.forecast, required this.checkDegree});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Humidity',
            style: AppStyles.h3
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 20,
          ),
          HumidityChart(listDaily: forecast.daily!),
          Text(
            'Humidity',
            style: AppStyles.h3
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 20,
          ),
          NextDayDetailsForecast(forecast: forecast, checkDegree: checkDegree),
        ]),
      ),
    );
  }
}

class HumidityChart extends StatelessWidget {
  List<Daily> listDaily;

  HumidityChart({required this.listDaily});

  @override
  Widget build(BuildContext context) {
    return MyColumnChart(listDaily: listDaily);
  }
}
