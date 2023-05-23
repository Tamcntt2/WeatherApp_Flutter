import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../utils/epoch_time.dart';
import '../utils/ui_utils.dart';
import 'my_separator.dart';

class MyCandleDailyChart extends StatelessWidget {
  Forecast forecast;

  MyCandleDailyChart({required this.forecast});

  @override
  Widget build(BuildContext context) {
    List<Daily>? listDaily = forecast.daily;
    List<int> listLow = [];
    List<int> listHigh = [];
    int count = 7;
    for (int i = 0; i < count; i++) {
      listLow.add(listDaily![i].temp!.min!.round());
      listHigh.add(listDaily[i].temp!.max!.round());
    }
    int tempMax =
        listHigh.reduce((value, element) => value > element ? value : element);
    return Container(
      child: Column(
        children: [
          Container(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return ItemCandleChart(
                    index: index,
                    tempMax: tempMax,
                    daily: listDaily![index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class ItemCandleChart extends StatelessWidget {
  int tempMax;
  Daily daily;
  int index;

  ItemCandleChart(
      {required this.index, required this.tempMax, required this.daily});

  @override
  Widget build(BuildContext context) {
    int tempHigh = daily.temp!.max!.round();
    int tempLow = daily.temp!.min!.round();
    return Container(
      width: (UIUtils.getScreenSize(context).width - 40) / 7,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                height: 250,
                child: Stack(children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 180.0 / tempMax * (tempMax - tempHigh) + 20,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '$tempHigh°',
                            style: AppStyles.h5
                                .copyWith(color: AppColors.lightGrey),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: index == 0
                                    ? Color(0xffF1B289)
                                    : Color(0xff595C66),
                                borderRadius: BorderRadius.circular(2.5)),
                            width: 5,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 180.0 / tempMax * tempLow + 20,
                        child: Text(
                          '$tempLow°',
                          style:
                              AppStyles.h5.copyWith(color: AppColors.lightGrey),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyColumnSeparator(
                          color: index == 0
                              ? Colors.transparent
                              : Color(0xff979797),
                          width: 0.25),
                    ],
                  )
                ]),
              ),
              Container(
                height: 10,
              ),
            ],
          ),
          Text(
            EpochTime.getWeekDay(daily.dt ?? 0),
            style: AppStyles.h5.copyWith(
                color: index == 0 ? Colors.white : AppColors.lightGrey),
          ),
        ],
      ),
    );
  }
}
