import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:weather_app/widgets/line_painter.dart';

import '../utils/epoch_time.dart';
import '../utils/setting_utits.dart';
import '../utils/ui_utils.dart';
import 'my_separator.dart';

class MyCandleHourlyChart extends StatefulWidget {
  Forecast forecast;
  int checkDegree;

  MyCandleHourlyChart({required this.forecast, required this.checkDegree});

  @override
  State<MyCandleHourlyChart> createState() =>
      _MyCandleHourlyChartState(checkDegree: checkDegree);
}

class _MyCandleHourlyChartState extends State<MyCandleHourlyChart> {
  final List<GlobalKey> listPointKey = List.generate(7, (index) => GlobalKey());
  List<Offset> listPoint = [];
  int checkDegree;

  _MyCandleHourlyChartState({required this.checkDegree});

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (dynamic key in listPointKey) {
        RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
        Offset center = box.localToGlobal(box.size.center(Offset.zero));
        listPoint.add(center);
      }
      print(listPoint.toString());
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Hourly>? listHourly = widget.forecast.hourly;
    List<int> listTemp = [];
    int count = 7;
    for (int i = 0; i < count; i++) {
      listTemp.add(listHourly![i].temp!.round());
    }
    return Stack(children: [
      SizedBox(
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return ItemCandleChart(
                key: listPointKey[index],
                index: index,
                hourly: listHourly![index],
                checkDegree: checkDegree,
              );
            }),
      ),
      // DrawLine(listPoint)
      // Text(
      //   listPoint.length.toString(),
      //   style: TextStyle(fontSize: 30),
      // )
    ]);
  }
}

class ItemCandleChart extends StatelessWidget {
  Hourly hourly;
  int index;
  int checkDegree;

  ItemCandleChart(
      {super.key,
      required this.index,
      required this.hourly,
      required this.checkDegree});

  @override
  Widget build(BuildContext context) {
    int temp = hourly.temp!.round();
    DateTime date = EpochTime.getDateTime(hourly.dt!);
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
                        height: 230.0 / 70 * (70 - temp),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            SettingUtits.getDegreeUnit(
                                temp * 1.0, false, checkDegree),
                            style: AppStyles.h5
                                .copyWith(color: AppColors.lightGrey),
                          ),
                        ),
                      ),
                      Expanded(
                        // key: key,
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
                        height: 230.0 / 70 * temp - 5,
                        child: Container(),
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
            '${date.hour}h',
            style: AppStyles.h5.copyWith(
                color: index == 0 ? Colors.white : AppColors.lightGrey),
          ),
        ],
      ),
    );
  }
}

class DrawLine extends StatelessWidget {
  List<Offset> listPoint;

  DrawLine(this.listPoint);

  @override
  Widget build(BuildContext context) {
    // print(listPoint.length);
    for (int i = 0; i < listPoint.length - 1; i++) {
      LinePainter(p1: listPoint[i], p2: listPoint[i + 1]);
    }
    return Stack(
      children: [
        for (int i = 0; i < listPoint.length - 1; i++)
          CustomPaint(
            painter: LinePainter(p1: listPoint[i], p2: listPoint[i + 1]),
          )
      ],
    );
  }
}
