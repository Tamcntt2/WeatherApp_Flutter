import 'package:flutter/material.dart';
import 'package:weather_app/values/app_colors.dart';
import 'package:weather_app/values/app_fonts.dart';

import '../../values/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff979797), Color(0xffF2F4F7)],
            ),
          ),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                AppAssets.sunSplash,
                width: 200,
                height: 147,
              ),
              Text(
                'Weather',
                style: TextStyle(
                  fontFamily: AppFonts.semiBold,
                  fontSize: 30,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 3),
                        blurRadius: 3),
                  ],
                ),
              ),
              Text(
                'Forecast',
                style: TextStyle(
                  fontFamily: AppFonts.regular,
                  fontSize: 28,
                  color: AppColors.textGrey,
                  shadows: [
                    Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 3),
                        blurRadius: 3),
                  ],
                ),
              )
            ]),
          )),
    ));
  }
}
