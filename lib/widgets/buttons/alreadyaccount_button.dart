import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AlreadyHaveAccountButton extends StatefulWidget {
  final String label;
  final Function onPressed;

  const AlreadyHaveAccountButton({Key? key, required this.label, required this.onPressed});

  @override
  _AlreadyHaveAccountButtonState createState() => _AlreadyHaveAccountButtonState();
}

class _AlreadyHaveAccountButtonState extends State<AlreadyHaveAccountButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPressed(),
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
          border: Border.all(
            color: Colors.white,
            width: 2.0, // Set your desired border width
          ),
          borderRadius: BorderRadius.circular(20.0),
          color: isPressed ? Colors.white.withOpacity(0.4) : Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 4), // Adjust the shadow offset as needed
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8), // Add space between icon and label
            AutoSizeText(
              widget.label,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              minFontSize: 11,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

