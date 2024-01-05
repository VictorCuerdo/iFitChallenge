// navigation_extension.dart
import 'package:flutter/material.dart';
import 'package:ifitchallenge/pages/Choose_Option.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(String routeName) {
    if (routeName == '/') {
      Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (context) => const ChooseOption()),
      );
    } else {
      Navigator.pushNamed(this, routeName);
    }
  }
}