// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'Choose_Option.dart';
import 'Auth/SignInPage.dart'; // Import your SignInPage class

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToSignInPage();
    _navigateToChooseOption();
  }

  _navigateToSignInPage() async {
    await Future.delayed(const Duration(seconds: 1), () {
      // Navigate to SignInPage after a delay
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInPage()));
    });
  }

  _navigateToChooseOption()async{
    await Future.delayed(const Duration(seconds: 1), () {
      // Navigate to SignInPage after a delay
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ChooseOption()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LottieBuilder.asset(
              'assets/animations/U.json',
              width: 250,
              height: 250,
              fit: BoxFit.fill,
              animate: true,
            ),
            const SizedBox(height: 15),
            RichText(
              text: const TextSpan(
                text: 'Unit',
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w500,
                    fontSize: 68),
                children: [
                  TextSpan(
                    text: 'App',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 68,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
