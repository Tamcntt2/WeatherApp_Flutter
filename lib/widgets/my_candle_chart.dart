import 'package:flutter/material.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../utils/ui_utils.dart';
import 'my_separator.dart';

class MyCandleChart extends StatelessWidget {
  List<int> listLow;
  List<int> listHigh;

  MyCandleChart(this.listLow, this.listHigh, {super.key});

  @override
  Widget build(BuildContext context) {
    int tempMax =
        listHigh.reduce((value, element) => value > element ? value : element);
    return Container(
      child: Column(
        children: [
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return ItemCandleChart(
                      index, listLow[index], listHigh[index], tempMax);
                }),
          ),
        ],
      ),
    );
  }
}

class ItemCandleChart extends StatelessWidget {
  int index;
  int tempLow;
  int tempHigh;
  int tempMax;

  ItemCandleChart(this.index, this.tempLow, this.tempHigh, this.tempMax,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (UIUtils.getScreenSize(context).width - 40) / 7,
      // width: double.infinity / 7,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                child: Stack(children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 160.0 / tempMax * (tempMax - tempHigh) + 20,
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
                        height: 160.0 / tempMax * tempLow + 20,
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
            'SUN',
            style: AppStyles.h5.copyWith(
                color: index == 0 ? Colors.white : AppColors.lightGrey),
          ),
        ],
      ),
    );
  }
}
