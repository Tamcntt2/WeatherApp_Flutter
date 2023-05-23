import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/forecast_daily.dart';
import 'package:weather_app/utils/epoch_time.dart';
import 'package:weather_app/utils/ui_utils.dart';
import 'package:weather_app/values/app_assets.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:http/http.dart' as http;

import '../../bloc/weather_state.dart';
import '../../models/air_quality.dart';
import '../../models/forecast.dart';
import '../../models/forecast_daily.dart';
import '../../widgets/my_separator.dart';
import '../models/location.dart';
import '../utils/current_location.dart';

class OverviewLocation extends StatefulWidget {
  final double lat;
  final double lon;

  OverviewLocation({required this.lat, required this.lon});

  @override
  State<OverviewLocation> createState() =>
      _OverviewLocationState(lat: lat, lon: lon);
}

class _OverviewLocationState extends State<OverviewLocation> {
  late Forecast forecast;
  late AirQuality airQuality;
  late ForecastDaily forecastDaily;

  final double lat;
  final double lon;

  _OverviewLocationState({required this.lat, required this.lon});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff484B5B), Color(0xff2C2D35)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial || state is WeatherLoading) {
                return const BuildLoading();
              } else if (state is WeatherLoaded) {
                forecast = state.forecast!;
                airQuality = state.airQuality!;
                forecastDaily = state.forecastDaily!;
                return ForecastView(
                    lat: lat,
                    lon: lon,
                    forecast: forecast,
                    airQuality: airQuality,
                    forecastDaily: forecastDaily);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class ForecastView extends StatelessWidget {
  final Forecast forecast;
  final AirQuality airQuality;
  final ForecastDaily forecastDaily;
  final double lat;
  final double lon;

  const ForecastView(
      {super.key,
      required this.forecast,
      required this.airQuality,
      required this.forecastDaily,
      required this.lat,
      required this.lon});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 17,
                )),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial || state is WeatherLoading) {
                  return Container();
                } else if (state is WeatherLoaded) {
                  MyLocation myLocation = state.myLocation!;
                  String textAddress =
                      '${myLocation.address!.city}, ${myLocation.address!.country}';
                  return Text(
                    UIUtils.convertNameCity(textAddress),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  );
                } else {
                  return Container();
                }
              },
            ),
            // FutureBuilder(
            //   builder: (context, snapshot) {
            //     String textAddress;
            //     if (snapshot.hasData) {
            //       textAddress =
            //           '${snapshot.data!.address!.city}, ${snapshot.data!.address!.country}';
            //     } else {
            //       textAddress = '';
            //     }
            //     return Text(
            //       UIUtils.convertNameCity(textAddress),
            //       style: AppStyles.h3.copyWith(
            //           color: Colors.white, fontWeight: FontWeight.bold),
            //     );
            //   },
            //   future: _fetchCurrentAddress(),
            // ),
            IconButton(
                onPressed: () {
                  // ...
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 17,
                )),
          ],
        ),
        TodayForecast(forecast: forecast),
        NextHourForecast(forecast: forecast),
        NextDayForecast(forecastDaily: forecastDaily, forecast: forecast),
        Details(forecast: forecast),
        AirQualityView(airQuality.listt![0].components!.pm10!),
        // const CoronavirusLastest(),
        SunMoon(forecast: forecast),
      ]),
    );
  }

  // Future<MyLocation> _fetchCurrentAddress() async {
  //   print('lat: $lat, lon: $lon');
  //   var recipesUrl = Uri.parse(
  //       'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon');
  //   final response = await http.get(recipesUrl);
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body);
  //     return MyLocation.fromJson(body);
  //   } else {
  //     throw Exception('Failed to load data from API');
  //   }
  // }
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
            child: Image.asset(
              AppAssets.iconWeather[hourly.weather![0].icon]!,
              width: 24,
              height: 18,
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
  ForecastDaily forecastDaily;
  Forecast forecast;

  NextDayForecast(
      {super.key, required this.forecastDaily, required this.forecast});

  @override
  State<NextDayForecast> createState() =>
      _NextDayForecastState(forecastDaily: forecastDaily, forecast: forecast);
}

class _NextDayForecastState extends State<NextDayForecast> {
  ForecastDaily forecastDaily;
  Forecast forecast;
  final List<bool> _isOpen = [false, false, false, false, false];

  _NextDayForecastState({required this.forecastDaily, required this.forecast});

  @override
  Widget build(BuildContext context) {
    // Map<int, List<Hourly3>> mapListHourly = {
    //   for (var i in List<int>.generate(7, (i) => i + 1)) i: <Hourly3>[]
    // };
    // DateTime dateCurrent = EpochTime.getDateTime(forecast.current!.dt!);
    // DateTime dateCompare = DateTime(
    //     dateCurrent.year, dateCurrent.month, dateCurrent.day + 1, 0, 0, 0);
    // List<Hourly3> list = forecastDaily.listDaily!;
    // int index = 0;
    //
    // for (Hourly3 i in list) {
    //   DateTime dateSelected = EpochTime.getDateTime(i.dt!);
    //   if (dateSelected.isAfter(dateCompare)) {
    //     index++;
    //     dateCompare = dateCompare.add(Duration(days: 1));
    //   }
    //   print('$index - $dateSelected - $dateCompare');
    //   mapListHourly[index]!.add(i);
    // }

    // for (int key in mapListHourly.keys) {
    //   print('Key: $key');
    //   List<Hourly3> values = mapListHourly[key]!;
    //   for (Hourly3 value in values) {
    //     print(value.toJson());
    //   }
    // }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 23, right: 23, top: 10, bottom: 20),
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
          padding: const EdgeInsets.only(right: 15, top: 10),
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
              // print(item.key);
              return ExpansionPanel(
                backgroundColor: Colors.transparent,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return DayCollapseForecast(
                      index: item.key, forecast: forecast);
                },
                // body: Container(),
                body: DayExpandForecast(
                    index: item.key,
                    forecastDaily: forecastDaily,
                    forecast: forecast),
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
        // InkWell(
        //   onTap: () {
        //     setState(() {
        //       for(bool i in _isOpen) {
        //         i = true;
        //       }
        //     });
        //   },
        //   child: Row(
        //     children: [
        //       Text(
        //         'Show more ',
        //         style: AppStyles.h4.copyWith(color: Colors.white),
        //       ),
        //       const Icon(
        //         Icons.expand_more_outlined,
        //         size: 10,
        //         color: Colors.white,
        //       ),
        //     ],
        //   ),
        // )
      ]),
    );
  }
}

class DayExpandForecast extends StatelessWidget {
  ForecastDaily forecastDaily;
  int index;
  Forecast forecast;

  DayExpandForecast(
      {super.key,
      required this.forecastDaily,
      required this.index,
      required this.forecast});

  @override
  Widget build(BuildContext context) {
    bool _isToday = index == 0;

    if (index < 2) {
      List<Hourly> listHourly = [];
      DateTime dtNow = EpochTime.getDateTime(forecast.current!.dt!);
      DateTime dtBegin = DateTime(
          dtNow.year, dtNow.month, dtNow.day + index, 0, dtNow.minute - 1);
      DateTime dtEnd = DateTime(
          dtNow.year, dtNow.month, dtNow.day + index, 24, dtNow.minute + 1);
      List<Hourly> listHourlyAll = forecast.hourly!;
      for (int i = 0; i <= listHourlyAll.length; i++) {
        DateTime dt = EpochTime.getDateTime(listHourlyAll[i].dt!);
        if (dt.isBefore(dtBegin)) continue;
        if (dt.isAfter(dtEnd)) break;
        listHourly.add(listHourlyAll[i]);
      }

      return SizedBox(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listHourly.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemDayExpandForecast(
                isCurrent: _isToday && index == 0,
                hour: getStringHourItemDayExpand(listHourly[index].dt),
                icon: listHourly[index].weather![0].icon!,
                temp: listHourly[index].temp,
              );
            }),
      );
    }

    List<Hourly3> listHourly = [];
    DateTime dtNow = EpochTime.getDateTime(forecastDaily.listDaily![0].dt!);
    DateTime dtBegin = DateTime(
        dtNow.year, dtNow.month, dtNow.day + index, 0, dtNow.minute - 1);
    DateTime dtEnd = DateTime(
        dtNow.year, dtNow.month, dtNow.day + index, 24, dtNow.minute + 1);
    List<Hourly3> listHourlyAll = forecastDaily.listDaily!;
    for (int i = 0; i <= listHourlyAll.length; i++) {
      DateTime dt = EpochTime.getDateTime(listHourlyAll[i].dt!);
      if (dt.isBefore(dtBegin)) continue;
      if (dt.isAfter(dtEnd)) break;
      listHourly.add(listHourlyAll[i]);
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listHourly.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemDayExpandForecast(
              isCurrent: _isToday && index == 0,
              icon: listHourly[index].weather![0].icon!,
              temp: listHourly[index].main!.temp,
              hour: getStringHourItemDayExpand(listHourly[index].dt),
            );
          }),
    );
  }

  String getStringHourItemDayExpand(int? dt) {
    DateTime dateSelected = EpochTime.getDateTime(dt!);
    String textHour = dateSelected.hour == 0
        ? '00 AM'
        : DateFormat('hh aaa').format(dateSelected);
    return textHour;
  }
}

class ItemDayExpandForecast extends StatelessWidget {
  bool isCurrent;
  double temp;
  String hour;
  String icon;

  ItemDayExpandForecast(
      {super.key,
      required this.hour,
      required this.temp,
      required this.icon,
      required this.isCurrent});

  @override
  Widget build(BuildContext context) {
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
        Image.asset(
          AppAssets.iconWeather[icon]!,
          height: 20,
          width: 25,
        ),
        Column(
          children: [
            Text(
              '${temp.round()}°',
              style: AppStyles.h4
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 5,
            ),
            Text(
              hour,
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
              width: 80,
              child: Text(
                index == 0
                    ? 'Today'
                    : DateFormat('EEEE').format(EpochTime.getDateTime(dt!)),
                style: AppStyles.h4.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
        Image.asset(
          AppAssets.iconWeather[daily.weather![0].icon]!,
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
            Image.asset(
              AppAssets.iconWeather[current?.weather?[0].icon]!,
              width: 150,
              height: 120,
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

class AirQualityView extends StatelessWidget {
  final double valuePM10;

  AirQualityView(this.valuePM10);

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
                    CirclePointer(valuePM10),
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${valuePM10.round()}',
                              style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 75,
                              child: Text(
                                textAlign: TextAlign.center,
                                getTextAirQuality(valuePM10),
                                style:
                                    AppStyles.h5.copyWith(color: Colors.white),
                              ),
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
    if (valuePM22 <= 250) return 'Very Unhealthy';
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
            SizedBox(
                height: 60,
                width: 90,
                child: Image.asset(
                  AppAssets.sunAni,
                  width: 90,
                  height: 60,
                )),
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
            SizedBox(
                height: 60,
                width: 90,
                child: Image.asset(
                  AppAssets.moonAni,
                  width: 90,
                  height: 60,
                )),
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
                Image.asset(
                  AppAssets.iconWeather[current?.weather?[0].icon]!,
                  width: 150,
                  height: 120,
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
