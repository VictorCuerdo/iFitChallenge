import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user_answer/user_answer_bloc.dart';
import '../../blocs/user_answer/user_answer_event.dart';
import '/../blocs/auth/auth_bloc.dart';
import '/../blocs/auth/auth_event.dart';

class AuthButton extends StatefulWidget {
  final String label;
  final Future<void> Function()? onPressed;
  final bool isLoginButton;
  final int? currentStep;
  final Function(int)? onStepSelected;

  const AuthButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoginButton = true,
    this.currentStep,
    this.onStepSelected,
  });

  @override
  _AuthButtonState createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool isPressed = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) async {
        setState(() => isPressed = false);

        if (!isLoading && widget.onPressed != null) {
          setState(() => isLoading = true);
          await widget.onPressed!();
          setState(() => isLoading = false);

          if (!widget.isLoginButton) {
            // Logic for non-login button, such as saving answers
            if (widget.currentStep != null) {
              // Trigger an event to save the answers
              // Replace with your actual logic to collect answers
              BlocProvider.of<UserAnswerBloc>(context).add(SaveAnswers({/* Your answers map here */}));
              widget.onStepSelected?.call(widget.currentStep! + 1); // Move to the next step
            }
          }
        }
      },
      onTapCancel: () => setState(() => isPressed = false),
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
              const Color(0xFFA54664).withOpacity(0.8),
              const Color(0xFFFC5C7D).withOpacity(0.8),
              const Color(0xFF005C97).withOpacity(0.8),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : () {
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          },
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
              if (isLoading)
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              const SizedBox(width: 8),
              if (!isLoading)
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






