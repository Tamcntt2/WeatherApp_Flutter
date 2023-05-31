import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location2.dart';
import 'package:weather_app/utils/setting_utits.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../../bloc/weather_bloc/weather_bloc.dart';
import '../../bloc/weather_bloc/weather_state.dart';
import '../../models/location.dart';
import '../../resources/api/api_repository.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff484B5B), Color(0xff2C2D35)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherInitial || state is WeatherLoading) {
            return Container();
          } else if (state is WeatherLoaded) {
            MyLocation myLocation = state.myLocation!;
            int checkDegree = state.checkDegree!;
            int checkDistance = state.checkDistance!;
            int checkSpeed = state.checkSpeed!;
            Forecast forecast = state.forecast!;
            return SearchPage(
                myLocation: myLocation,
                checkDegree: checkDegree,
                checkDistance: checkDistance,
                checkSpeed: checkSpeed,
                forecast: forecast);
          } else {
            return Container();
          }
        }),
      )),
    );
  }
}

class SearchPage extends StatelessWidget {
  MyLocation myLocation;
  int checkDegree;
  int checkDistance;
  int checkSpeed;
  Forecast forecast;

  SearchPage(
      {super.key,
      required this.forecast,
      required this.myLocation,
      required this.checkDistance,
      required this.checkDegree,
      required this.checkSpeed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 17,
              )),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 17,
            )),
        title: Center(
          child: Text(
            'Search Location',
            style: AppStyles.h3
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SearchView(),
          Container(
            height: 20,
          ),
          Expanded(
              child: LocationView(
                  currentLocation: myLocation,
                  forecast: forecast,
                  checkDegree: checkDegree))
        ]),
      ),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          // onChanged: (value) {
          //   setState(() {
          //     _text = value;
          //   });
          // },
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Enter the city name',
            filled: true,
            fillColor: const Color(0xff56586a),
            prefixIconColor: AppColors.lightGrey,
            hintStyle: AppStyles.h3.copyWith(color: AppColors.lightGrey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: TextButton(
                onPressed: () {
                  _textFieldController.clear();
                  // _focusNode.unfocus();
                },
                child: const Text('Cancel')),
          ),
          controller: _textFieldController,
          // focusNode: _focusNode,
          style: const TextStyle(color: AppColors.lightGrey),
        ),
        suggestionsCallback: (pattern) async {
          return await StateService.getSuggestions(pattern);
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.displayName!),
          );
        },
        onSuggestionSelected: (suggestion) {
          _textFieldController.text = suggestion.displayName!;
          // ... open overview
        });
  }
}

class LocationView extends StatelessWidget {
  MyLocation currentLocation;
  Forecast forecast;
  int checkDegree;

  LocationView(
      {super.key,
      required this.checkDegree,
      required this.currentLocation,
      required this.forecast});

  @override
  Widget build(BuildContext context) {
    List<MyLocation> listLocation = [];
    listLocation.add(currentLocation);

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listLocation.length,
        itemBuilder: (BuildContext context, int index) {
          // return const Placeholder();
          return ItemLocation(
              listLocation[index], index == 0, forecast, checkDegree);
        });
  }
}

class ItemLocation extends StatelessWidget {
  MyLocation location;
  bool isCurrent;
  Forecast forecast;
  int checkDegree;

  ItemLocation(this.location, this.isCurrent, this.forecast, this.checkDegree,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff56586a)),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${location.address!.city}, ${location.address!.country}',
                    style: AppStyles.h2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 3,
                  ),
                  Text(
                    DateFormat('hh:mm').format(DateTime.now()),
                    style: AppStyles.h3.copyWith(color: Colors.white),
                  )
                ],
              ),
              Text(
                SettingUtits.getDegreeUnit(
                    forecast.current!.temp!, true, checkDegree),
                style: AppStyles.h3.copyWith(color: Colors.white, fontSize: 30),
              )
            ],
          ),
          Container(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Clouds',
                style: AppStyles.h3.copyWith(color: Colors.white),
              ),
              Text(
                'Min: ${SettingUtits.getDegreeUnit(forecast.daily![0].temp!.min!, false, checkDegree)} - Max: ${SettingUtits.getDegreeUnit(forecast.daily![0].temp!.max!, false, checkDegree)}',
                style: AppStyles.h3.copyWith(color: Colors.white),
              )
            ],
          )
        ]),
      ),
    );
  }
}

class StateService {
  static Future<List<MyLocation2>> getSuggestions(String query) async {
    final ApiRepository apiRepository = ApiRepository();
    final List<MyLocation2> locations =
        await apiRepository.fetchListLocationFromAddress(query);
    return locations;
  }
}
