import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../utils/epoch_time.dart';
import '../utils/setting_utits.dart';
import '../utils/ui_utils.dart';
import 'my_separator.dart';

class MyCandleDailyChart extends StatelessWidget {
  Forecast forecast;
  int checkDegree;

  MyCandleDailyChart(
      {super.key, required this.forecast, required this.checkDegree});

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
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return ItemCandleChart(
                  index: index,
                  tempMax: tempMax,
                  daily: listDaily![index],
                  checkDegree: checkDegree,
                );
              }),
        ),
      ],
    );
  }
}

class ItemCandleChart extends StatelessWidget {
  int tempMax;
  Daily daily;
  int index;
  int checkDegree;

  ItemCandleChart(
      {super.key,
      required this.index,
      required this.tempMax,
      required this.daily,
      required this.checkDegree});

  @override
  Widget build(BuildContext context) {
    int tempHigh = daily.temp!.max!.round();
    int tempLow = daily.temp!.min!.round();
    return SizedBox(
      width: (UIUtils.getScreenSize(context).width - 40) / 7,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 250,
                child: Stack(children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 180.0 / tempMax * (tempMax - tempHigh) + 20,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            SettingUtits.getDegreeUnit(
                                tempHigh * 1.0, false, checkDegree),
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
                                    ? const Color(0xffF1B289)
                                    : const Color(0xff595C66),
                                borderRadius: BorderRadius.circular(2.5)),
                            width: 5,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 180.0 / tempMax * tempLow + 20,
                        child: Text(
                          SettingUtits.getDegreeUnit(
                              tempLow * 1.0, false, checkDegree),
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
                              : const Color(0xff979797),
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
