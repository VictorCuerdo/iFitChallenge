import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MyButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor:  Colors.transparent,
        backgroundColor:  Colors.white, // Updated to transparent background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0), // Matching the border radius
          side: const BorderSide(color: Colors.black54, width: 1.0),
        ),
        elevation: 0.0, // No elevation
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
          vertical: MediaQuery.of(context).size.width * 0.05,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black, // Updated to white color
              fontSize: 18.0, // Adjusted font size
              fontWeight: FontWeight.bold,
              fontFamily: 'Open Sans',
            ),
            maxLines: 1,
            minFontSize: 11.0,
          ),
        ],
      ),
    );
  }
}

class ButtonTexts {
  static const String button1Label = "OUT OF BREATH";
  static const String button2Label = "SOMEWHAT TIRED";
  static const String button3Label = "EASY";
  static const String button4Label = "I CAN RUN THEM UP";
}

class ButtonWidgetStep4 extends StatelessWidget {
  final int currentStep;
  final Function(int) onStepSelected;

  const ButtonWidgetStep4({super.key, required this.currentStep, required this.onStepSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyButton(
          label: ButtonTexts.button1Label,
          onPressed: () {
            onStepSelected(currentStep + 1);
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        MyButton(
          label: ButtonTexts.button2Label,
          onPressed: () {
            onStepSelected(currentStep + 1);
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        MyButton(
          label: ButtonTexts.button3Label,
          onPressed: () {
            onStepSelected(currentStep + 1);
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        MyButton(
          label: ButtonTexts.button4Label,
          onPressed: () {
            onStepSelected(currentStep + 1);
          },
        ),
      ],
    );
  }
}



