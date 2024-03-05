import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ifitchallenge/pages/PlanDisplay.dart';
import 'package:lottie/lottie.dart';
import 'Choose_Option.dart'; // Make sure this is the correct path for your 'Choose_Option' file
import 'Auth/SignInPage.dart';
import 'Home_Page.dart'; // Import your SignInPage class

class LoadingPlan extends StatefulWidget {
  const LoadingPlan({super.key});

  @override
  _LoadingPlanState createState() => _LoadingPlanState();
}

class _LoadingPlanState extends State<LoadingPlan> {
  late Timer _timer;
  int _displayState = 0;

  static const firstAnimationDuration = Duration(seconds: 6);
  static const secondAnimationDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    startTimer(firstAnimationDuration);
  }

  void startTimer(Duration duration) {
    _timer = Timer(duration, () {
      setState(() {
        if (_displayState == 0) {
          // First animation displayed, now display second
          _displayState = 1;
          startTimer(secondAnimationDuration);
        } else {
          // Second animation displayed, navigate to HomePage and cancel the timer
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const PlanDisplay()),);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 20, left:4, right:4),
            child: AutoSizeText(
              'CREATING YOUR TRAINING PLAN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 14,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          LottieBuilder.asset(
            _displayState == 0
                ? 'assets/animations/pushups.json'
                : 'assets/animations/successful.json',
            width: _displayState == 0 ? 300 : 500,
            height: _displayState == 0 ? 300 : 400,
            fit: BoxFit.fill,
            animate: true,
          ),
        ],
      ),
    );
  }
}







