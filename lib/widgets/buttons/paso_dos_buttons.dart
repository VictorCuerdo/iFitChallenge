import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class GenderSelectionWidget extends StatefulWidget {
  final int currentStep;
  final Function(int, String) onStepSelected; // Updated function type

  const GenderSelectionWidget({
    super.key,
    required this.currentStep,
    required this.onStepSelected,
  });

  @override
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  bool isWomenSelected = false;
  bool isMenSelected = false;
  bool isNextButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildGenderButton(
            imagePath: 'assets/images/woman.png',
            label: 'Women',
            isSelected: isWomenSelected,
            onPressed: () {
              _updateSelection(true, false);
              widget.onStepSelected(widget.currentStep + 1, 'Women'); // Updated
            },
            size: screenWidth * 0.4,
          ),
          _buildGenderButton(
            imagePath: 'assets/images/man.png',
            label: 'Men',
            isSelected: isMenSelected,
            onPressed: () {
              _updateSelection(false, true);
              widget.onStepSelected(widget.currentStep + 1, 'Men'); // Updated
            },
            size: screenWidth * 0.4,
          ),
        ],
      ),
    );
  }

  void _updateSelection(bool womenSelected, bool menSelected) {
    setState(() {
      isWomenSelected = womenSelected;
      isMenSelected = menSelected;
    });
  }

  Widget _buildGenderButton({
    required String imagePath,
    required String label,
    required bool isSelected,
    required VoidCallback onPressed,
    required double size,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: size,
            height: size,//
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected && !isNextButtonPressed
                  ? null // Remove the extra "gradient" here
                  : Colors.transparent,
              border: Border.all(
                color: isSelected ? const Color(0xFFFC5C7D): Colors.white.withOpacity(0.5),
                width: size * 0.01,
              ),
              gradient: isSelected && !isNextButtonPressed
                  ? RadialGradient(
                colors: [
                  const Color(0xFFA54664).withOpacity(0.8),
                  const Color(0xFF005C97).withOpacity(0.8),
                  // const Color(0xFFFC5C7D).withOpacity(0.5),
                ],
                center: Alignment.center,
                radius: 0.8,
              )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(size * 0.03),
              child: Image.asset(
                imagePath,
                width: size,
                height: size,
                cacheHeight: (size * 0.8).toInt(),
                cacheWidth: (size * 0.8).toInt(),
              ),
            ),
          ),
          SizedBox(height: size * 0.05),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size * 0.1,
              fontFamily: 'Open Sans',
              color: isSelected && !isNextButtonPressed
                  ? const Color(0xFFFC5C7D)
                  : Colors.white,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}