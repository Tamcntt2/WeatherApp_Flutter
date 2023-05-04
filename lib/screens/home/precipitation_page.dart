import 'package:flutter/material.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:weather_app/widgets/my_column_chart.dart';

import '../../widgets/next_day_details_forecast.dart';

class PrecipitationPage extends StatelessWidget {
  const PrecipitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Precipitation',
            style: AppStyles.h3
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 20,
          ),
          PrecipitationChart(),
          Text(
            'Precipitation',
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

class PrecipitationChart extends StatelessWidget {
  const PrecipitationChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> listDegrees = [30, 50, 70, 50, 60, 10, 20];
    return MyColumnChart(listDegrees);
  }
}
