import 'package:flutter/material.dart';

class StepBarWidget extends StatelessWidget {
  final int stepNumber;
  final int totalSteps;

  const StepBarWidget({
    super.key,
    required this.stepNumber,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StepProgressBar(stepNumber: stepNumber, totalSteps: totalSteps),

      ],
    );
  }
}

class StepProgressBar extends StatelessWidget {
  final int stepNumber;
  final int totalSteps;

  const StepProgressBar({
    super.key,
    required this.stepNumber,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    double progress = stepNumber / totalSteps;
    double progressBarWidth = MediaQuery.of(context).size.width * 0.7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Step $stepNumber / $totalSteps',
            style: const TextStyle(
              fontFamily: 'Open Sans',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: progressBarWidth,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF44BB74),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



