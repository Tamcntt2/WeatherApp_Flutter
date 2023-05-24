import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:weather_app/widgets/my_candle_daily_chart.dart';

import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_state.dart';
import '../../models/forecast.dart';
import '../../widgets/my_candle_hourly_chart.dart';
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

class TemperatureView extends StatefulWidget {
  Forecast forecast;

  TemperatureView({required this.forecast});

  @override
  State<TemperatureView> createState() => _TemperatureViewState();
}

class _TemperatureViewState extends State<TemperatureView> {
  bool _isOverview = false;
  int _isSwitched = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              ? TemperatureDailyChart(forecast: widget.forecast)
              : TemperatureHourlyChart(forecast: widget.forecast),
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
          NextDayDetailsForecast(forecast: widget.forecast),
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

  TemperatureHourlyChart({required this.forecast});

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
        child: MyCandleHourlyChart(forecast: forecast));
  }
}

class TemperatureDailyChart extends StatelessWidget {
  Forecast forecast;

  TemperatureDailyChart({required this.forecast});

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
        child: MyCandleDailyChart(forecast: forecast));
  }
}
