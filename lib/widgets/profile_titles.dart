import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfileTextWidget extends StatelessWidget {
  final int caseNumber;

  const ProfileTextWidget({super.key, required this.caseNumber});

  @override
  Widget build(BuildContext context) {
    String title = "";
    String subtitle = "";

    switch (caseNumber) {
      case 1:
        title = "WHAT IS YOUR GOAL?";
        subtitle = "Reach your goal with a custom plan";
        break;
      case 2:
        title = "TELL US ABOUT YOURSELF";
        subtitle = "Let us know you better to improve your training results";
        break;
      case 3:
        title = "HOW OFTEN DO YOU DO EXERCISE?";
        subtitle = "";
        break;
      case 4:
        title = "How do you feel after going up 5 floors?";
        subtitle = "";
        break;
      case 5:
        title = "How many consecutive push-ups can you do?";
        subtitle = "";
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          title,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Open Sans',
            //color: Color(0xFF44BB74),
            color:Color(0xFFDCFFCC),
          ),
          maxLines: 2,
          minFontSize: 8,
          overflowReplacement: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Open Sans',
              color: Colors.white,
            ),
          ),
          textScaleFactor: 0.9,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          maxFontSize: 38,
          stepGranularity: 1,
          presetFontSizes: const [30, 20, 16, 12], //
        ),
        const SizedBox(height: 8), // Adjust the spacing between title and subtitle
        AutoSizeText(
          subtitle,
          style: const TextStyle(
            fontSize: 24 - 4 ,
            color: Colors.white,

            fontFamily: 'Open Sans',
          ),
          maxLines: 2,
          minFontSize: 8,
          overflowReplacement: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.black,
              fontFamily: 'Open Sans',
            ),
          ),
          textScaleFactor: 0.9,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          maxFontSize: 24,
          stepGranularity: 1,
          presetFontSizes: const [24, 20, 16, 12],
        ),
      ],
    );
  }
}


