import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppleAuthButton extends StatefulWidget {
  final String label;
  final Function onPressed;

  const AppleAuthButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  _AppleAuthButtonState createState() => _AppleAuthButtonState();
}

class _AppleAuthButtonState extends State<AppleAuthButton> {
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
            color: const Color(0xFF3C3C3C), // Set your desired border color
            width: 2.0, // Set your desired border width
          ),
          borderRadius: BorderRadius.circular(20.0),
          color: isPressed ? Colors.black.withOpacity(0.7) : Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 4), // Adjust the shadow offset as needed
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/apple_icon.png', // Add your Apple logo asset path
              height: 32, // Set your desired height
              width: 32, // Set your desired width
            ),
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
