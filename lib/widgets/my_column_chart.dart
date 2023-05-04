import 'package:flutter/material.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../utils/ui_utils.dart';
import 'my_separator.dart';

class MyColumnChart extends StatelessWidget {
  List<int> listDegrees;

  MyColumnChart(this.listDegrees, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return ItemColumnChart(index, listDegrees[index]);
                }),
          ),
        ],
      ),
    );
  }
}

class ItemColumnChart extends StatelessWidget {
  int index;
  int degrees;

  ItemColumnChart(this.index, this.degrees, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (UIUtils.getScreenSize(context).width - 40) / 7,
      // width: double.infinity / 7,
      child: Column(
        children: [
          Text(
            'SUN',
            style: AppStyles.h5.copyWith(
                color: index == 0 ? Colors.white : AppColors.lightGrey),
          ),
          Container(
            height: 30,
          ),
          Column(
            children: [
              Container(
                height: 200,
                child: Stack(children: [
                  Column(
                    children: [
                      Container(
                        height: 200 / 100 * (100 - degrees),
                      ),
                      Container(
                        height: 200 / 100 * degrees,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: index.floor().isEven
                                  ? [Color(0xffD2D2D3), Color(0xff80838A)]
                                  : [Color(0xff98999C), Color(0xff98999C)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyColumnSeparator(color: Color(0xff979797), width: 0.25),
                      MyColumnSeparator(
                          color: index == 6
                              ? Color(0xff979797)
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
                '$degrees%',
                style: AppStyles.h4.copyWith(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
