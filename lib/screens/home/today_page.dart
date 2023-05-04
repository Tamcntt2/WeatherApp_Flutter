import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_app/values/app_assets.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../../widgets/my_separator.dart';

class TodayPage extends StatefulWidget {
  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  late int currentHour;

  @override
  Widget build(BuildContext context) {
    currentHour = 2;
    return SingleChildScrollView(
      child: Column(children: [
        const TodayForecast(),
        NextHourForecast(currentHour),
        NextDayForecast(),
        const Details(),
        AirQuality(31),
        const CoronavirusLastest(),
        const SunMoon(),
      ]),
    );
  }
}

class NextHourForecast extends StatelessWidget {
  int currentHour;

  NextHourForecast(this.currentHour, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 27),
      child: ListView.builder(
          padding: const EdgeInsets.only(right: 14),
          scrollDirection: Axis.horizontal,
          itemCount: 24,
          itemBuilder: (BuildContext context, int index) {
            return ItemHourForecast(index + 1, currentHour == index + 1);
          }),
    );
  }
}

class ItemHourForecast extends StatelessWidget {
  int hour;
  bool checkCurrent;

  ItemHourForecast(this.hour, this.checkCurrent, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 46,
      margin: const EdgeInsets.only(left: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: checkCurrent
              ? Border.all(color: Colors.white)
              : Border.all(color: Colors.transparent),
          color:
              checkCurrent ? const Color(0xff686975) : const Color(0xff3A3D4B)),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            hour > 9 ? '$hour:00' : '0$hour:00',
            style: AppStyles.h6.copyWith(
                color: checkCurrent ? Colors.white : AppColors.lightGrey),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Image.asset(
              AppAssets.sunCloudy,
              width: 24,
              height: 18,
            ),
          ),
          Text('26°', style: AppStyles.h4.copyWith(color: Colors.white))
        ]),
      ),
    );
  }
}

class NextDayForecast extends StatefulWidget {
  const NextDayForecast({Key? key}) : super(key: key);

  @override
  State<NextDayForecast> createState() => _NextDayForecastState();
}

class _NextDayForecastState extends State<NextDayForecast> {
  final List<bool> _isOpen = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 23, right: 23, top: 10, bottom: 25),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [Color(0xff232329), Color(0xff2F313A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Text(
            'High    |    Low',
            style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          // height: 200,
          child: ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.only(top: 0),
            elevation: 0,
            dividerColor: Colors.transparent,
            children: _isOpen.map<ExpansionPanel>((bool item) {
              return ExpansionPanel(
                backgroundColor: Colors.transparent,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return DayCollapseForecast();
                },
                body: DayExpandForecast(),
                isExpanded: item,
              );
            }).toList(),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _isOpen[panelIndex] = !_isOpen[panelIndex];
              });
            },
          ),
          // child: ListView.builder(
          //     padding: const EdgeInsets.only(right: 14),
          //     scrollDirection: Axis.vertical,
          //     itemCount: 5,
          //     itemBuilder: (BuildContext context, int index) {
          //       bool isExpand = false;
          //       return isExpand ? const ItemDayExpandForecast() : ItemDayCollapseForecast();
          //     }),
        ),
        Row(
          children: [
            Text(
              'Show more ',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
            const Icon(
              Icons.expand_more_outlined,
              size: 10,
              color: Colors.white,
            ),
          ],
        )
      ]),
    );
  }
}

class DayExpandForecast extends StatelessWidget {
  const DayExpandForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 24,
          itemBuilder: (BuildContext context, int index) {
            return ItemDayExpandForecast();
          }),
    );
  }
}

class ItemDayExpandForecast extends StatelessWidget {
  const ItemDayExpandForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 40,
      margin: EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff36373C), Color(0xff2A2C32)],
          )),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset(
          AppAssets.sunCloudy,
          height: 20,
          width: 25,
        ),
        Column(
          children: [
            Text(
              '71°',
              style: AppStyles.h4
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 5,
            ),
            Text(
              '6 AM',
              style: AppStyles.h6.copyWith(color: AppColors.lightGrey),
            )
          ],
        )
      ]),
    );
  }
}

class DayCollapseForecast extends StatelessWidget {
  const DayCollapseForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.expand_more_outlined,
                size: 15,
                color: AppColors.lightGrey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Today',
                  style: AppStyles.h4.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
          Image.asset(
            AppAssets.sunCloudy,
            height: 19,
            width: 24,
          ),
          Row(
            children: [
              Text('86°', style: AppStyles.h4.copyWith(color: Colors.white)),
              Padding(
                padding: const EdgeInsets.only(left: 23, right: 0),
                child: Text('67°',
                    style: AppStyles.h4.copyWith(color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25, top: 10, bottom: 30),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [Color(0xff232329), Color(0xff2F313A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text('Details',
                style: AppStyles.h3.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset(AppAssets.sunCloudy),
            Container(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemDetail('Feels like', '76°'),
                  ItemDetail('Humidity', '63%'),
                  ItemDetail('Visibility', '10 mi'),
                  ItemDetail('UV Index', 'Low 0'),
                  ItemDetail('Dew point', '56°'),
                ],
              ),
            )
          ]),
          Center(
            child: Text(
              'Tonight - Clear. Winds from SW to SSW at 10 to 11 mph \n(16.1 to 17.7 kph). The overnight low will be 69° F (20.0 ° C)',
              style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
            ),
          )
        ],
      ),
    );
  }
}

class ItemDetail extends StatelessWidget {
  String title;
  String content;

  ItemDetail(this.title, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
        ),
        Text(
          content,
          style: AppStyles.h4.copyWith(color: Colors.white),
        )
      ],
    );
  }
}

class AirQuality extends StatelessWidget {
  double valuePM22;

  AirQuality(this.valuePM22);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25, top: 10, bottom: 30, left: 25),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [Color(0xff232329), Color(0xff2F313A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Air Quality',
                  style: AppStyles.h3.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const Icon(
                Icons.info_outline,
                size: 12,
                color: Colors.white,
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                width: 110,
                height: 110,
                child: Stack(
                  children: [
                    CirclePointer(valuePM22),
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$valuePM22',
                              style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              getTextAirQuality(valuePM22),
                              style: AppStyles.h5.copyWith(color: Colors.white),
                            )
                          ]),
                    )
                  ],
                )),
            Container(
                child: Text(
                    'You have good air quality - enjoy \nyour outdoor activities.',
                    style: AppStyles.h5.copyWith(color: AppColors.lightGrey)))
          ]),
          MySeparator(color: Color(0xff979797), height: 0.25),
          Container(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'US EPA AQI ',
                    style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
                    children: <TextSpan>[
                      TextSpan(
                          text: '49/500',
                          style: AppStyles.h5.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Dominant pollutant ',
                    style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'PM 10',
                          style: AppStyles.h5.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getTextAirQuality(double valuePM22) {
    if (valuePM22 <= 12) return 'Good';
    if (valuePM22 <= 35.4) return 'Moderate';
    if (valuePM22 <= 55.4) return 'Unhealthy for Sensitive Groups';
    if (valuePM22 <= 150.4) return 'Unhealthy';
    if (valuePM22 <= 250.4) return 'Very Unhealthy';
    return 'Hazardous';
  }
}

class CirclePointer extends StatelessWidget {
  var valuePM25;

  CirclePointer(this.valuePM25, {super.key});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 250,
          showTicks: false,
          showLabels: false,
          axisLineStyle: AxisLineStyle(
              thickness: 0.1,
              thicknessUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.bothCurve),
          pointers: <GaugePointer>[
            RangePointer(
              value: valuePM25,
              width: 0.1,
              sizeUnit: GaugeSizeUnit.factor,
              gradient: const SweepGradient(
                  colors: <Color>[Color(0xFFDBE350), Color(0xFFFE1D1D)],
                  stops: <double>[0.25, 0.75]),
              cornerStyle: CornerStyle.bothCurve,
            )
          ],
        )
      ],
    );
  }
}

class CoronavirusLastest extends StatelessWidget {
  const CoronavirusLastest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25, top: 10, bottom: 16, left: 25),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [Color(0xff2F313A), Color(0xff232329)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Coronavirus Lastest',
                  style: AppStyles.h3.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const Icon(
                Icons.more_horiz,
                size: 12,
                color: Colors.white,
              )
            ],
          ),
          Container(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tamil Nadu, Chennai',
                    style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text('Confirmed Cases',
                      style: AppStyles.h4.copyWith(color: Colors.white))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total',
                        style:
                            AppStyles.h4.copyWith(color: AppColors.lightGrey),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: const Color(0xff32333E),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text('10,51,666',
                              style:
                                  AppStyles.h4.copyWith(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Today',
                        style:
                            AppStyles.h4.copyWith(color: AppColors.lightGrey),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text('+1,045',
                              style:
                                  AppStyles.h4.copyWith(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Container(
            height: 24,
          ),
          MySeparator(color: Color(0xff979797), height: 0.25),
          Container(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'More detail ',
                style: AppStyles.h4.copyWith(color: Colors.white),
              ),
              const Icon(
                Icons.expand_more_outlined,
                size: 10,
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SunMoon extends StatelessWidget {
  const SunMoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25, top: 10, bottom: 30, left: 25),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [Color(0xff232329), Color(0xff2F313A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sun & Moon',
              style: AppStyles.h3
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          Container(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Text('05:57 AM',
                    style: AppStyles.h3.copyWith(color: Colors.white)),
                Container(
                  height: 10,
                ),
                Text('Sunrise',
                    style: AppStyles.h3.copyWith(color: AppColors.lightGrey))
              ],
            ),
            Container(height: 60, width: 90, child: const Placeholder()),
            Column(
              children: [
                Text('06:12 PM',
                    style: AppStyles.h3.copyWith(color: Colors.white)),
                Container(
                  height: 10,
                ),
                Text('Sunset',
                    style: AppStyles.h3.copyWith(color: AppColors.lightGrey))
              ],
            ),
          ]),
          Container(
            height: 30,
          ),
          MySeparator(color: Color(0xff979797), height: 0.25),
          Container(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Text('10:09 AM',
                    style: AppStyles.h3.copyWith(color: Colors.white)),
                Container(
                  height: 10,
                ),
                Text('Moon rise',
                    style: AppStyles.h3.copyWith(color: AppColors.lightGrey))
              ],
            ),
            Container(height: 60, width: 90, child: const Placeholder()),
            Column(
              children: [
                Text('23:18 PM',
                    style: AppStyles.h3.copyWith(color: Colors.white)),
                Container(
                  height: 10,
                ),
                Text('Moon set',
                    style: AppStyles.h3.copyWith(color: AppColors.lightGrey))
              ],
            ),
          ]),
        ],
      ),
    );
  }
}

class TodayForecast extends StatelessWidget {
  const TodayForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 11, bottom: 7),
            decoration: BoxDecoration(
                color: const Color(0xff32333E),
                borderRadius: BorderRadius.circular(16)),
            height: 28,
            width: 116,
            child: Center(
              child: Text(
                'Saturday, 11 Sept',
                style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Image.asset(
                AppAssets.sunCloudy,
                width: 120,
                height: 95,
              ),
            ]),
            Column(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                            colors: [Color(0xffA2A4B5), Color(0xff545760)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)
                        .createShader(bounds);
                  },
                  child: const Text(
                    '33°',
                    style: TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text('Partly cloudy',
                    style: AppStyles.h5.copyWith(color: Colors.white)),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
              text: TextSpan(
                text: '29°/27° | Feels like ',
                style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
                children: <TextSpan>[
                  TextSpan(
                      text: '39°C',
                      style: AppStyles.h5.copyWith(color: Colors.white)),
                ],
              ),
            ),
            Text(
              '|',
              style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
            ),
            RichText(
              text: TextSpan(
                text: 'Wind ',
                style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
                children: <TextSpan>[
                  TextSpan(
                      text: '9 KM',
                      style: AppStyles.h5.copyWith(color: Colors.white)),
                  TextSpan(
                    text: '/H WSW',
                    style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
        // RichText(
        //   text: TextSpan(
        //     text: '29°/27° | Feels like ',
        //     style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
        //     children: <TextSpan>[
        //       TextSpan(
        //           text: '39°C',
        //           style: AppStyles.h5.copyWith(color: Colors.white)),
        //       TextSpan(
        //           text: '              |              Wind ',
        //           style: AppStyles.h5.copyWith(color: AppColors.lightGrey)),
        //       TextSpan(
        //           text: '9 KM',
        //           style: AppStyles.h5.copyWith(color: Colors.white)),
        //       TextSpan(
        //         text: '/H WSW',
        //         style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
        //       ),
        //     ],
        //   ),
        // ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 21),
          child: MySeparator(color: Color(0xff979797), height: 0.25),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTodayForecast(AppAssets.sunCloudy, 'Precipitation', '21%'),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 29),
                child:
                    ItemTodayForecast(AppAssets.sunCloudy, 'Wind', '10 km/h'),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTodayForecast(AppAssets.sunCloudy, 'Humidity', '59%'),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 29),
                child: ItemTodayForecast(AppAssets.sunCloudy, 'Sunset', '29%'),
              ),
            ],
          )
        ]),
      ],
    );
  }
}

class ItemTodayForecast extends StatelessWidget {
  String image;
  String title;
  String forecast;

  ItemTodayForecast(this.image, this.title, this.forecast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(
        image,
        height: 16,
        width: 20,
      ),
      Text(
        '$title: ',
        style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
      ),
      Text(
        forecast,
        style: AppStyles.h5.copyWith(color: Colors.white),
      )
    ]);
  }
}
