import 'package:flutter/material.dart';
import 'package:weather_app/values/app_styles.dart';

import '../../models/location.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff484B5B), Color(0xff2C2D35)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Location',
            style: AppStyles.h3
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SearchView(),
          Location()
        ]),
      )),
    ));
  }
}

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MyLocation> listLocation = [];
    listLocation.add(MyLocation(
        name: 'Hà Nội', latitude: 21.030653, longtitude: 105.847130));

    return Placeholder();
    // return ListView.builder(
    //     padding: const EdgeInsets.only(right: 14),
    //     scrollDirection: Axis.vertical,
    //     itemCount: listLocation.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return ItemLocation(listLocation[index], index == 0);
    //     });
  }
}

class ItemLocation extends StatelessWidget {
  MyLocation location;
  bool isCurrent;

  ItemLocation(this.location, this.isCurrent);

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
