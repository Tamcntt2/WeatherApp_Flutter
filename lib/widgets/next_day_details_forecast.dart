import 'package:flutter/material.dart';
import 'package:weather_app/values/app_assets.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_styles.dart';

class NextDayDetailsForecast extends StatelessWidget {
  const NextDayDetailsForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      // height: 200,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(right: 14),
          scrollDirection: Axis.vertical,
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            return ItemDayDetailsForecast();
          }),
    );
  }
}

class ItemDayDetailsForecast extends StatelessWidget {
  const ItemDayDetailsForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [Color(0xff454650), Color(0xff353742)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'SUN',
              style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
            ),
            Text(
              'SEP 12',
              style: AppStyles.h4.copyWith(color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(AppAssets.sunCloudy, height: 30),
            Container(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Thunderstorms',
                  style: AppStyles.h4.copyWith(color: AppColors.yellow),
                ),
                Text(
                  'ssw 11 km/h',
                  style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '33° / 28°',
                  style: AppStyles.h4.copyWith(color: Colors.white),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 12,
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      '30%',
                      style: AppStyles.h4.copyWith(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            Container(
              width: 24,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.white,
            )
          ],
        )
      ]),
    );
  }
}
