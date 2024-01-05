import 'package:flutter/material.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';
import '../widgets/buttons/alreadyaccount_button.dart';
import '../widgets/buttons/startnow_button.dart';

class ChooseOption extends StatelessWidget {
  const ChooseOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_signin9.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Buttons at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // START NOW Button
                  StartNowButton(label: 'START NOW',
                    onPressed: () {
                    context.navigateTo('/ProfileChooser');
                  },),
                  const SizedBox(height: 16.0), // Add some spacing between buttons

                  // I ALREADY HAVE AN ACCOUNT Button
                  AlreadyHaveAccountButton( label: 'ALREADY HAVE AN ACCOUNT',
                    onPressed: () {
                      context.navigateTo('/SignIn');
                    },),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
