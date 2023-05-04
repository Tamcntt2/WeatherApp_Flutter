import 'package:flutter/material.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:weather_app/widgets/my_candle_chart.dart';

import '../../widgets/next_day_details_forecast.dart';

class TemperaturePage extends StatelessWidget {
  const TemperaturePage({Key? key}) : super(key: key);

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
          TemperatureChart(),
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
          NextDayDetailsForecast(),
        ]),
      ),
    );
  }
}

class TemperatureChart extends StatelessWidget {
  const TemperatureChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> listMin = [19, 15, 21, 19, 23, 20, 19];
    List<int> listMax = [30, 31, 35, 32, 35, 29, 28];

    return Container(
        padding: EdgeInsets.only(top: 35),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xff232329), Color(0xff2F313A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(10)),
        child: MyCandleChart(listMin, listMax));
  }
}
