import 'package:flutter/material.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '../../pages/Profile_Chooser.dart';

class NextButton extends StatefulWidget {
  final String label;
  final Function? onPressed;

  const NextButton({super.key, required this.label, required this.onPressed});

  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              const Color(0xFFA54664).withOpacity(0.7),
              const Color(0xFFFC5C7D).withOpacity(0.7),
              const Color(0xFF005C97).withOpacity(0.7),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed != null ? () => widget.onPressed!() : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isPressed ? Colors.green.withOpacity(0.5) : Colors.transparent,
            minimumSize: const Size(200, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 8),
              AutoSizeText(
                widget.label,
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                minFontSize: 11,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



