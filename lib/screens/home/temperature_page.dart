import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:weather_app/widgets/my_candle_daily_chart.dart';

import '../../bloc/weather_bloc/weather_bloc.dart';
import '../../bloc/weather_bloc/weather_state.dart';
import '../../models/forecast.dart';
import '../../widgets/my_candle_hourly_chart.dart';
import '../../widgets/next_day_details_forecast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemperaturePage extends StatelessWidget {
  late Forecast forecast;
  late int checkDegree;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherInitial || state is WeatherLoading) {
        return const BuildLoading();
      } else if (state is WeatherLoaded) {
        forecast = state.forecast!;
        checkDegree = state.checkDegree!;
        return TemperatureView(
          forecast: forecast,
          checkDegree: checkDegree,
        );
      } else {
        return Container();
      }
    });
  }
}

class TemperatureView extends StatefulWidget {
  Forecast forecast;
  int checkDegree;

  TemperatureView(
      {super.key, required this.forecast, required this.checkDegree});

  @override
  State<TemperatureView> createState() =>
      _TemperatureViewState(checkDegree: checkDegree);
}

class _TemperatureViewState extends State<TemperatureView> {
  int _isSwitched = 1;
  int checkDegree;

  _TemperatureViewState({required this.checkDegree});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Temperature',
              style: AppStyles.h3
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ToggleSwitch(
                minWidth: 60,
                fontSize: 10,
                minHeight: 23,
                initialLabelIndex: _isSwitched,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.white54,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: const ['Hourly', 'Daily'],
                activeBgColors: const [
                  [Colors.black38],
                  [Colors.black38]
                ],
                onToggle: (index) {
                  setState(() {
                    _isSwitched = index!;
                  });
                },
              ),
            ),
          ]),
          Container(
            height: 20,
          ),
          // TemperatureHourlyChart(forecast: widget.forecast),
          _isSwitched == 1
              ? TemperatureDailyChart(
                  forecast: widget.forecast,
                  checkDegree: checkDegree,
                )
              : TemperatureHourlyChart(
                  forecast: widget.forecast,
                  checkDegree: checkDegree,
                ),
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
          NextDayDetailsForecast(
              forecast: widget.forecast, checkDegree: checkDegree),
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

class TemperatureHourlyChart extends StatelessWidget {
  Forecast forecast;
  int checkDegree;

  TemperatureHourlyChart(
      {super.key, required this.forecast, required this.checkDegree});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 35),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xff232329), Color(0xff2F313A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(10)),
        child: MyCandleHourlyChart(
          forecast: forecast,
          checkDegree: checkDegree,
        ));
  }
}

class TemperatureDailyChart extends StatelessWidget {
  Forecast forecast;
  int checkDegree;

  TemperatureDailyChart(
      {super.key, required this.forecast, required this.checkDegree});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 35),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xff232329), Color(0xff2F313A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(10)),
        child: MyCandleDailyChart(
          forecast: forecast,
          checkDegree: checkDegree,
        ));
  }
}
