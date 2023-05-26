import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/utils/epoch_time.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../utils/ui_utils.dart';
import 'my_separator.dart';

class MyColumnChart extends StatelessWidget {
  List<Daily> listDaily;

  MyColumnChart({super.key, required this.listDaily});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return ItemColumnChart(
                    index: index,
                    timestamps: listDaily[index].dt!,
                    humidity: listDaily[index].humidity!);
              }),
        ),
      ],
    );
  }
}

class ItemColumnChart extends StatelessWidget {
  int timestamps;
  int humidity;
  int index;

  ItemColumnChart(
      {super.key,
      required this.index,
      required this.timestamps,
      required this.humidity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (UIUtils.getScreenSize(context).width - 40) / 7,
      // width: double.infinity / 7,
      child: Column(
        children: [
          Text(
            EpochTime.getWeekDay(timestamps),
            style: AppStyles.h5.copyWith(
                color: index == 0 ? Colors.white : AppColors.lightGrey),
          ),
          Container(
            height: 30,
          ),
          Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(children: [
                  Column(
                    children: [
                      Container(
                        height: 200 / 100 * (100 - humidity),
                      ),
                      Container(
                        height: 200 / 100 * humidity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: index.floor().isEven
                                  ? [
                                      const Color(0xffD2D2D3),
                                      const Color(0xff80838A)
                                    ]
                                  : [
                                      const Color(0xff98999C),
                                      const Color(0xff98999C)
                                    ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyColumnSeparator(
                          color: Color(0xff979797), width: 0.25),
                      MyColumnSeparator(
                          color: index == 6
                              ? const Color(0xff979797)
                              : Colors.transparent,
                          width: 0.25),
                    ],
                  )
                ]),
              ),
              Container(
                height: 10,
              ),
              Text(
                '$humidity%',
                style: AppStyles.h4.copyWith(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
