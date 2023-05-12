import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/utils/epoch_time.dart';
import 'package:weather_app/utils/ui_utils.dart';
import 'package:weather_app/values/app_assets.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../../bloc/weather_state.dart';
import '../../models/forecast.dart';
import '../../widgets/my_separator.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  late Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial || state is WeatherLoading) {
          return const BuildLoading();
        } else if (state is WeatherLoaded) {
          forecast = state.forecast!;
          return TodayView(forecast: forecast);
        } else {
          return Container();
        }
      },
    );
  }
}

class TodayView extends StatelessWidget {
  final Forecast forecast;

  const TodayView({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        TodayForecast(forecast: forecast),
        NextHourForecast(forecast: forecast),
        NextDayForecast(forecast: forecast),
        Details(forecast: forecast),
        AirQuality(31),
        const CoronavirusLastest(),
        SunMoon(forecast: forecast),
      ]),
    );
  }
}

class BuildLoading extends StatelessWidget {
  const BuildLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class NextHourForecast extends StatelessWidget {
  Forecast forecast;

  NextHourForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 27),
      child: ListView.builder(
          padding: const EdgeInsets.only(right: 14),
          scrollDirection: Axis.horizontal,
          itemCount: 12,
          itemBuilder: (BuildContext context, int index) {
            return ItemHourForecast(
                index: index, hourly: forecast.hourly![index]);
          }),
    );
  }
}

class ItemHourForecast extends StatelessWidget {
  int index;
  Hourly hourly;

  ItemHourForecast({super.key, required this.index, required this.hourly});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = DateTime(currentDate.year, currentDate.month,
        currentDate.day, currentDate.hour + index);
    int selectedHour = selectedDate.hour;
    bool checkCurrent = (index == 0);
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
            selectedHour > 9 ? '$selectedHour:00' : '0$selectedHour:00',
            style: AppStyles.h6.copyWith(
                color: checkCurrent ? Colors.white : AppColors.lightGrey),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Transform.scale(
              scale: 1.5,
              alignment: Alignment.center,
              child: Image.network(
                'http://openweathermap.org/img/wn/${hourly.weather?[0].icon}@4x.png',
                width: 24,
                height: 18,
                color: Colors.transparent,
              ),
            ),
          ),
          Text('${hourly.temp?.round()}°',
              style: AppStyles.h4.copyWith(color: Colors.white))
        ]),
      ),
    );
  }
}

class NextDayForecast extends StatefulWidget {
  Forecast forecast;

  NextDayForecast({super.key, required this.forecast});

  @override
  State<NextDayForecast> createState() =>
      _NextDayForecastState(forecast: forecast);
}

class _NextDayForecastState extends State<NextDayForecast> {
  Forecast forecast;
  final List<bool> _isOpen = [false, false, false, false, false];

  _NextDayForecastState({required this.forecast});

  @override
  Widget build(BuildContext context) {
    List<Daily>? listDaily = forecast.daily;
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
            expandedHeaderPadding: const EdgeInsets.only(top: 0),
            elevation: 0,
            dividerColor: Colors.transparent,
            children: _isOpen.asMap().entries.map<ExpansionPanel>((item) {
              print(item.key);
              return ExpansionPanel(
                backgroundColor: Colors.transparent,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return DayCollapseForecast(
                      index: item.key, forecast: forecast);
                },
                body: DayExpandForecast(index: item.key, forecast: forecast),
                isExpanded: item.value,
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
  Forecast forecast;
  int index;

  DayExpandForecast({super.key, required this.forecast, required this.index});

  @override
  Widget build(BuildContext context) {
    bool _isToday = index == 0;
    List<Hourly>? listHourlyAll = forecast.hourly;
    int dtCurrent = forecast.current!.dt!;
    int hourCurrent = EpochTime.getDateTime(dtCurrent).hour;
    int start = _isToday ? 0 : index * 24 - hourCurrent;
    int end = 24 - hourCurrent + index * 24;
    List<Hourly> listHourly = [];
    for (int i = start; i <= end; i++) {
      listHourly.add(listHourlyAll![i]);
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listHourly.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemDayExpandForecast(
                hourly: listHourly[index], isCurrent: _isToday && index == 0);
          }),
    );
  }
}

class ItemDayExpandForecast extends StatelessWidget {
  Hourly hourly;
  bool isCurrent;

  ItemDayExpandForecast(
      {super.key, required this.hourly, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    DateTime dateSelected = EpochTime.getDateTime(hourly.dt!);
    String textHour = dateSelected.hour == 0
        ? '00 AM'
        : DateFormat('hh aaa').format(dateSelected);
    return Container(
      height: 90,
      width: 40,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isCurrent
              ? Border.all(color: Colors.white)
              : Border.all(color: Colors.transparent),
          color: isCurrent ? const Color(0xff686975) : const Color(0xff3A3D4B),
          gradient: isCurrent
              ? null
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff36373C), Color(0xff2A2C32)],
                )),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.network(
          'http://openweathermap.org/img/wn/${hourly.weather![0].icon}@4x.png',
          height: 20,
          width: 25,
        ),
        Column(
          children: [
            Text(
              '${hourly.temp!.round()}°',
              style: AppStyles.h4
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 5,
            ),
            Text(
              textHour,
              style: AppStyles.h6.copyWith(color: AppColors.lightGrey),
            )
          ],
        )
      ]),
    );
  }
}

class DayCollapseForecast extends StatelessWidget {
  Forecast forecast;
  int index;

  DayCollapseForecast({super.key, required this.forecast, required this.index});

  @override
  Widget build(BuildContext context) {
    Daily daily = forecast.daily![index];
    int? dt = daily.dt;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.expand_more_outlined,
              size: 15,
              color: AppColors.lightGrey,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              width: 60,
              child: Text(
                index == 0
                    ? 'Today'
                    : DateFormat('EEEE').format(EpochTime.getDateTime(dt!)),
                style: AppStyles.h4.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
        Image.network(
          'http://openweathermap.org/img/wn/${daily.weather![0].icon}@4x.png',
          height: 35,
          width: 35,
        ),
        Row(
          children: [
            Text('${daily.temp!.max!.round()}°',
                style: AppStyles.h4.copyWith(color: Colors.white)),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 0),
              child: Text('${daily.temp!.min!.round()}°',
                  style: AppStyles.h4.copyWith(color: Colors.white)),
            ),
          ],
        )
      ],
    );
  }
}

class Details extends StatelessWidget {
  Forecast forecast;

  Details({required this.forecast});

  @override
  Widget build(BuildContext context) {
    Current? current = forecast.current;
    return Container(
      padding: const EdgeInsets.only(right: 25, top: 10, bottom: 20),
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
            Image.network(
              'http://openweathermap.org/img/wn/${current?.weather?[0].icon}@4x.png',
              width: 180,
              height: 130,
            ),
            SizedBox(
              width: 130,
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemDetail('Feels like', '${current?.feelsLike?.round()}°'),
                  ItemDetail('Humidity', '${current?.humidity}%'),
                  ItemDetail('Visibility', '${current?.visibility} m'),
                  ItemDetail('UV Index', '${current?.uvi?.round()}'),
                  ItemDetail('Dew point', '${current?.dewPoint?.round()}°'),
                ],
              ),
            )
          ]),
          // Center(
          //   child: Text(
          //     'Tonight - Clear. Winds from SW to SSW at 10 to 11 mph \n(16.1 to 17.7 kph). The overnight low will be 69° F (20.0 ° C)',
          //     style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
          //   ),
          // )
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

  AirQuality(this.valuePM22, {super.key});

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
                margin:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
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
                              style: const TextStyle(
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
            Text('You have good air quality - enjoy \nyour outdoor activities.',
                style: AppStyles.h5.copyWith(color: AppColors.lightGrey))
          ]),
          const MySeparator(color: Color(0xff979797), height: 0.25),
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
          axisLineStyle: const AxisLineStyle(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
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
          const MySeparator(color: Color(0xff979797), height: 0.25),
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
  Forecast forecast;

  SunMoon({super.key, required this.forecast});

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
                Text(
                    DateFormat('hh:mm aaa').format(
                        EpochTime.getDateTime(forecast.current!.sunrise!)),
                    style: AppStyles.h3.copyWith(color: Colors.white)),
                Container(
                  height: 10,
                ),
                Text('Sunrise',
                    style: AppStyles.h3.copyWith(color: AppColors.lightGrey))
              ],
            ),
            const SizedBox(height: 60, width: 90, child: Placeholder()),
            Column(
              children: [
                Text(
                    DateFormat('hh:mm aaa').format(
                        EpochTime.getDateTime(forecast.current!.sunset!)),
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
          const MySeparator(color: Color(0xff979797), height: 0.25),
          Container(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Text(
                    DateFormat('hh:mm aaa').format(
                        EpochTime.getDateTime(forecast.daily![0].moonrise!)),
                    style: AppStyles.h3.copyWith(color: Colors.white)),
                Container(
                  height: 10,
                ),
                Text('Moon rise',
                    style: AppStyles.h3.copyWith(color: AppColors.lightGrey))
              ],
            ),
            const SizedBox(height: 60, width: 90, child: Placeholder()),
            Column(
              children: [
                Text(
                    DateFormat('hh:mm aaa').format(
                        EpochTime.getDateTime(forecast.daily![0].moonset!)),
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

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 115,
      top: 41,
      child: Align(
        child: SizedBox(
          width: 110,
          height: 55,
          child: Image.asset(
            AppAssets.sunset,
            width: 110,
            height: 55,
          ),
        ),
      ),
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

class TodayForecast extends StatelessWidget {
  final Forecast forecast;

  const TodayForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    Current? current = forecast.current;

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
                DateFormat.MMMMEEEEd().format(DateTime.now()),
                style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
              ),
            )),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.5,
                  alignment: Alignment.center,
                  child: Image.network(
                    'http://openweathermap.org/img/wn/${current?.weather?[0].icon}@4x.png',
                    width: 120,
                    height: 95,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                            colors: [Color(0xffA2A4B5), Color(0xff545760)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)
                        .createShader(bounds);
                  },
                  child: Text(
                    '${current?.temp?.round()}°',
                    style: const TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Feels like ',
                    style: AppStyles.h5.copyWith(color: AppColors.lightGrey),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${current?.feelsLike?.round()}°C',
                          style: AppStyles.h5.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                Text(
                    UIUtils.capitalizeAllWord(
                        current?.weather?[0].description ?? ''),
                    style: AppStyles.h5.copyWith(color: Colors.white)),
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 21),
          child: MySeparator(color: Color(0xff979797), height: 0.25),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTodayForecast(AppAssets.sunCloudy, 'Wind speed',
                  '${current?.windSpeed} m/s'),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 29),
                child: ItemTodayForecast(AppAssets.sunCloudy, 'Wind gust',
                    '${current?.windGust} m/s'),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTodayForecast(
                  AppAssets.sunCloudy, 'Humidity', '${current?.humidity}%'),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 29),
                child: ItemTodayForecast(
                    AppAssets.sunCloudy, 'Clouds', '${current?.clouds}%'),
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
