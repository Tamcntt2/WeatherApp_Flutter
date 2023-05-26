import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/location2.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

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
        child: Scaffold(
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
                'Seacrh Location',
                style: AppStyles.h3
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SearchView(),
              Container(
                height: 20,
              ),
              const Expanded(child: LocationView())
            ]),
          ),
        ),
      )),
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
          this._textFieldController.text = suggestion.displayName!;
          // ... open overview
        });
  }
}

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    // List<MyLocation> listLocation = [];
    // listLocation.add(MyLocation(
    //     name: 'Hà Nội', latitude: 21.030653, longtitude: 105.847130));

    return ListView.builder(
        scrollDirection: Axis.vertical,
        // itemCount: listLocation.length,
        itemBuilder: (BuildContext context, int index) {
          return const Placeholder();
          // return ItemLocation(listLocation[index], index == 0);
        });
  }
}

class ItemLocation extends StatelessWidget {
  MyLocation location;
  bool isCurrent;

  ItemLocation(this.location, this.isCurrent, {super.key});

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
                  Text(
                    DateFormat('hh:mm').format(DateTime.now()),
                    style: AppStyles.h3.copyWith(color: Colors.white),
                  )
                ],
              ),
              Text(
                '32°',
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
                'C:32° T:24°',
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
