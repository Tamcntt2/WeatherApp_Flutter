import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weather_app/utils/ui_utils.dart';
import 'package:weather_app/values/app_assets.dart';
import 'package:weather_app/values/app_styles.dart';

import '../home/home_screen.dart';

class StepperPage4 extends StatelessWidget {
  const StepperPage4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 3;
    int countIndex = 4;
    String title = 'Detailed Hourly \nForecast';
    String describe = 'Get in - depth weather \ninformation.';
    String image = AppAssets.stepper4;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff2C2D35), Color(0xff484B5B)],
            ),
          ),
          child: Column(children: [
            Expanded(
                child: Center(
              child: SizedBox(
                height: 300,
                width: 300,
                child: Stack(
                  children: [
                    Image.asset(image),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SizedBox(
                          height: 6,
                          width: 47,
                          child: ListView.builder(
                            reverse: false,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return buildIndicator(index == currentIndex);
                            },
                            itemCount: countIndex,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false);
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
                child: Stack(
              children: [
                Transform.scale(
                    scale: 1.25,
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                UIUtils.getScreenSize(context).width),
                            topLeft: Radius.circular(
                                UIUtils.getScreenSize(context).width)),
                      ),
                    )),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppStyles.h1Stepper,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 49),
                        child: Text(
                          describe,
                          style: AppStyles.h2Stepper,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 4.0,
                        percent: (currentIndex + 1) / countIndex,
                        center: Ink(
                          width: 53.33,
                          height: 53.33,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xff484B5B), Color(0xff2C2D35)],
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                  (route) => false);
                            },
                            child: const Icon(Icons.arrow_forward_outlined,
                                color: Colors.white),
                          ),
                        ),
                        // progressColor: Colors.green,
                        circularStrokeCap: CircularStrokeCap.round,
                        linearGradient: const LinearGradient(
                          colors: [Color(0xffC23ACC), Color(0xffFF4F80)],
                        ),
                      )
                    ],
                  ),
                ),
              ],
              //
            ))
          ]),
        ),
      ),
    );
  }
}

Widget buildIndicator(bool isActive) {
  return Container(
      margin: const EdgeInsets.only(right: 5),
      width: isActive ? 14 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ));
}
