import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

import '../../models/location.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff484B5B), Color(0xff2C2D35)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Text(
                  'Location',
                  style: AppStyles.h2.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            SearchView(),
            Container(
              height: 20,
            ),
            Expanded(child: LocationView())
          ]),
        ),
      )),
    );
  }


}

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textFieldController = TextEditingController();

  final _focusNode = FocusNode();

  // String _text = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TypeAheadField(
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
              fillColor: Color(0xff56586a),
              prefixIconColor: AppColors.lightGrey,
              hintStyle: AppStyles.h3.copyWith(color: AppColors.lightGrey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.circular(20), // thiết lập border radius
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.circular(20), // thiết lập border radius
              ),
              prefixIcon: Icon(Icons.search),
              suffixIcon: TextButton(
                  onPressed: () {
                    _textFieldController.clear();
                    // _focusNode.unfocus();
                  },
                  child: Text('Cancel')),
            ),
            controller: this._textFieldController,
            // focusNode: _focusNode,
            style: TextStyle(color: AppColors.lightGrey),
          ),
          suggestionsCallback: (pattern) async {
            return await StateService.getSuggestions(pattern);
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            this._textFieldController.text = suggestion;
          }),
    );
  }
}

class LocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MyLocation> listLocation = [];
    listLocation.add(MyLocation(
        name: 'Hà Nội', latitude: 21.030653, longtitude: 105.847130));

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listLocation.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemLocation(listLocation[index], index == 0);
        });
  }
}

class ItemLocation extends StatelessWidget {
  MyLocation location;
  bool isCurrent;

  ItemLocation(this.location, this.isCurrent);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xff56586a)),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
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
  static final List<String> states = [
    'ANDAMAN AND NICOBAR ISLANDS',
    'ANDHRA PRADESH',
    'ARUNACHAL PRADESH',
    'ASSAM',
    'BIHAR',
    'CHATTISGARH',
    'CHANDIGARH',
    'DAMAN AND DIU',
    'DELHI',
    'DADRA AND NAGAR HAVELI',
    'GOA',
    'GUJARAT',
    'HIMACHAL PRADESH',
    'HARYANA',
    'JAMMU AND KASHMIR',
    'JHARKHAND',
    'KERALA',
    'KARNATAKA',
    'LAKSHADWEEP',
    'MEGHALAYA',
    'MAHARASHTRA',
    'MANIPUR',
    'MADHYA PRADESH',
    'MIZORAM',
    'NAGALAND',
    'ORISSA',
    'PUNJAB',
    'PONDICHERRY',
    'RAJASTHAN',
    'SIKKIM',
    'TAMIL NADU',
    'TRIPURA',
    'UTTARAKHAND',
    'UTTAR PRADESH',
    'WEST BENGAL',
    'TELANGANA',
    'LADAKH'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
