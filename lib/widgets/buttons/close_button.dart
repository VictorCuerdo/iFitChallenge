import 'package:flutter/material.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';

class ClosexButton extends StatelessWidget {
  const ClosexButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.1; // Adjust the size as needed

    return IconButton(
      icon: Icon(Icons.close, color: Colors.white.withOpacity(0.7), size: iconSize),
      onPressed: () {
        context.navigateTo('/ChooseOption');
      },
      splashRadius: iconSize * 0.6, // Adjust the splash radius for touch feedback
      padding: EdgeInsets.zero, // Remove default padding
      constraints: const BoxConstraints(), // Remove any constraints to allow shrinking
    );
  }
}

