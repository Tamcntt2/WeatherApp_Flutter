import 'package:flutter/material.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

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
              Text(
                'More',
                style: AppStyles.h3.copyWith(color: Colors.blue),
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
          title: Text(
            'Chennai, TN',
            style: AppStyles.h3
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
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
          onTap: () {},
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
