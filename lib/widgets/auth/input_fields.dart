import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  bool isPasswordVisible;

  CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.isPassword,
    required this.onChanged,
    required this.onSubmitted,
    this.isPasswordVisible = false,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AutoSizeText(
            widget.label,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              color: Color(0xFFE6E6E6),
              fontSize: 16.0,
            ),
            minFontSize: 11,
            maxLines: 1,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFF272729),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Open Sans',
            ),
            obscureText: widget.isPassword && !widget.isPasswordVisible,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (widget.isPassword) {
                if (value!.length < 8) {
                  return 'Password must be at least 8 characters';
                }
              } else {
                final emailRegex =
                RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
                if (!emailRegex.hasMatch(value!)) {
                  return 'Enter a valid email address';
                }
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFFA2A2A4),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  widget.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: widget.isPasswordVisible
                      ? const Color(0xFFFC5C7D).withOpacity(0.8)
                      : const Color(0xFFA2A2A4),
                ),
                onPressed: () {
                  setState(() {
                    widget.isPasswordVisible =
                    !widget.isPasswordVisible;
                  });
                },
              )
                  : null,
              border: InputBorder.none,
            ),
            keyboardType: widget.isPassword
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress,
            autocorrect: false,
          ),
        ),
      ],
    );
  }
}


