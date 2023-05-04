import 'package:flutter/material.dart';
import 'package:weather_app/screens/stepper/stepper_page_1.dart';

class StepperScreen extends StatelessWidget {
  const StepperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: StepperPage1(),
    ));
  }
}
