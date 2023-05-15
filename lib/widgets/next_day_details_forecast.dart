import 'package:flutter/material.dart';
import 'package:weather_app/utils/ui_utils.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../models/forecast.dart';
import '../utils/epoch_time.dart';
import '../values/app_assets.dart';

class NextDayDetailsForecast extends StatelessWidget {
  Forecast forecast;

  NextDayDetailsForecast({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      // height: 200,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(right: 14),
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            Daily daily = forecast.daily![index];
            return ItemDayDetailsForecast(daily: daily);
          }),
    );
  }
}

class ItemDayDetailsForecast extends StatelessWidget {
  Daily daily;

  ItemDayDetailsForecast({required this.daily});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [Color(0xff454650), Color(0xff353742)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${EpochTime.getWeekDay(daily.dt!)}',
              style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
            ),
            Text(
              '${EpochTime.getMonth(daily.dt!)} ${EpochTime.getDateTime(daily.dt!).day}',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(AppAssets.iconWeather[daily.weather![0].icon]!,
                height: 40),
            Container(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  UIUtils.capitalizeAllWord(daily.weather![0].description!),
                  style: AppStyles.h4.copyWith(color: AppColors.yellow),
                ),
                Text(
                  'wind ${daily.windSpeed!.round()} km/h',
                  style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${daily.temp!.min!.round()}° / ${daily.temp!.max!.round()}°',
                  style: AppStyles.h4.copyWith(color: Colors.white),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 12,
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      '${daily.humidity}%',
                      style: AppStyles.h4.copyWith(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            Container(
              width: 24,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.white,
            )
          ],
        )
      ]),
    );
  }
}
