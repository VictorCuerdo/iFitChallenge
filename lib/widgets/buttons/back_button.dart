import 'package:flutter/material.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';

class BackxButton extends StatelessWidget {
  final VoidCallback onBackPressed;

  const BackxButton({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.08; // Adjust the size as needed

    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: iconSize),
      onPressed: onBackPressed,
      splashRadius: iconSize * 0.6, // Adjust the splash radius for touch feedback
      padding: EdgeInsets.zero, // Remove default padding
      constraints: const BoxConstraints(), // Remove any constraints to allow shrinking
    );
  }
}