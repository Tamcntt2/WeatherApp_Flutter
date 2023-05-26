import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screens/search/search_screen.dart';
import 'package:weather_app/screens/setting/setting_screen.dart';
import 'package:weather_app/utils/ui_utils.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';
import 'package:http/http.dart' as http;

import '../../bloc/weather_bloc/weather_bloc.dart';
import '../../bloc/weather_bloc/weather_state.dart';
import '../../models/location.dart';
import '../../utils/current_location.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff232329), Color(0xff2F313A)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
      ),
      child: Column(
        children: [
          Expanded(flex: 1, child: DrawerUser()),
          Expanded(flex: 3, child: DrawerLocation()),
          Expanded(flex: 6, child: DrawerTools()),
        ],
      ),
    );
  }
}

class DrawerLocation extends StatelessWidget {
  const DrawerLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 0.2,
          color: AppColors.lightGrey,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 40),
          child: Row(
            children: [
              Text(
                'Location',
                style: AppStyles.h3.copyWith(color: AppColors.lightGrey),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '|',
                  style: TextStyle(color: AppColors.lightGrey),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                },
                child: Text(
                  'More',
                  style: AppStyles.h3.copyWith(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
        ListTile(
          horizontalTitleGap: 0,
          leading: const Icon(
            Icons.location_on,
            color: Colors.white,
            size: 19,
          ),
          title: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial || state is WeatherLoading) {
                return Container();
              } else if (state is WeatherLoaded) {
                MyLocation myLocation = state.myLocation!;
                String textAddress =
                    '${myLocation.address!.city}, ${myLocation.address!.country}';
                return Text(
                  UIUtils.convertNameCity(textAddress),
                  style: AppStyles.h3.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                );
              } else {
                return Container();
              }
            },
          ),
          // title: FutureBuilder(
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
          //           fontWeight: FontWeight.bold, color: Colors.white),
          //     );
          //   },
          //   future: _fetchCurrentAddress(),
          // )
          // title: Text(
          // 'Ha Noi, Viet Nam',
          // style: AppStyles.h3
          //     .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          // ),
        ),
      ],
    );
  }

// Future<MyLocation> _fetchCurrentAddress() async {
//   Position position = await CurrentLocation.getCurrentLocation();
//   double lat = position.latitude;
//   double lon = position.longitude;
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

class DrawerTools extends StatelessWidget {
  const DrawerTools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 0.2,
          color: AppColors.lightGrey,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 40),
          child: Text(
            'Tools',
            style: AppStyles.h3.copyWith(color: AppColors.lightGrey),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 19,
          ),
          title: Text(
            'Notifications',
            style: AppStyles.h3
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 19,
          ),
          title: Text(
            'Settings',
            style: AppStyles.h3
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.message,
            color: Colors.white,
            size: 19,
          ),
          title: Text(
            'Sed Feedback',
            style: AppStyles.h3
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.star,
            color: Colors.white,
            size: 19,
          ),
          title: Text(
            'Rate this app',
            style: AppStyles.h3
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.share,
            color: Colors.white,
            size: 19,
          ),
          title: Text(
            'Share your weather',
            style: AppStyles.h3
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}

class DrawerUser extends StatelessWidget {
  const DrawerUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white)),
              Text(
                'Sign in',
                style: AppStyles.h2
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
