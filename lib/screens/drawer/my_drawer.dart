import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/login/login_screen.dart';
import 'package:weather_app/screens/search/search_screen.dart';
import 'package:weather_app/screens/setting/setting_screen.dart';
import 'package:weather_app/utils/ui_utils.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';
import '../../bloc/weather_bloc/weather_bloc.dart';
import '../../bloc/weather_bloc/weather_state.dart';
import '../../models/location.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
        children: const [
          Expanded(flex: 1, child: DrawerUser()),
          Expanded(flex: 3, child: DrawerLocation()),
          Expanded(flex: 6, child: DrawerTools()),
        ],
      ),
    );
  }
}

class DrawerLocation extends StatelessWidget {
  const DrawerLocation({super.key});

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
                        builder: (context) => const SearchScreen(),
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
        ),
      ],
    );
  }
}

class DrawerTools extends StatefulWidget {
  const DrawerTools({super.key});

  @override
  State<DrawerTools> createState() => _DrawerToolsState();
}

class _DrawerToolsState extends State<DrawerTools> {
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
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const SettingScreen(),
            //     ),
            //     (route) => false);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Center(child: Icon(Icons.account_circle))),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
                child: Text(
                  'Sign in',
                  style: AppStyles.h2.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.close,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
