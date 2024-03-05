import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/auth/auth_divider.dart';
import '../../widgets/auth/input_fields.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/social_media_buttons/apple_auth_button.dart';
import '../../widgets/auth/social_media_buttons/facebook_auth_button.dart';
import '../../widgets/auth/social_media_buttons/google_auth_button.dart';
import '../../widgets/buttons/back_button.dart';
import '../../widgets/stepBarWidget.dart';
import '../../pages/Profile_Chooser.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../pages/Home_Page.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';

class SignUpPage extends StatefulWidget {
  final ProfileChooserState profileChooserState;

  const SignUpPage({super.key, required this.profileChooserState});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = '';
  String _password = '';
  String _errorMessage = '';
  bool _isLoading = false;
  int currentStep = 6; // Step number for SignUpPage

  Future<void> _signUpWithEmail() async {
    if (_email.isEmpty || _password.isEmpty) {
      setState(() => _errorMessage = "Email and password cannot be empty");
      return;
    }
    try {
      setState(() => _isLoading = true);
      // Dispatch event to AuthBloc
      BlocProvider.of<AuthBloc>(context).add(EmailSignInRequested(email: _email, password: _password));
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double defaultPadding = 16.0;

    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 15),
                Row(
                  children: [
                    BackxButton(
                      onBackPressed: () {
                        if (widget.profileChooserState.currentStep > ProfileChooserState.minStep) {
                          widget.profileChooserState.onStepSelected(
                              widget.profileChooserState.currentStep - 1, ''); // Added empty string as a placeholder
                        } else {
                          Navigator.of(context).pop(); // Or navigate to a specific route if needed
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(left: defaultPadding),
                  child: const Row(
                    children: [
                      Text(
                        "Create an account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.orangeAccent,
                        size: 32.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsets.only(left: defaultPadding),
                  child: const Text(
                    "Welcome! Please enter your details",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontFamily: 'Open Sans',
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: defaultPadding),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        GoogleAuthButton(
                          label: 'Sign up with Google',
                          onSuccess: (UserCredential userCredential) {
                            Navigator.of(context).pushReplacementNamed('/HomePage');
                          },
                          onError: (Exception error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Google Sign-Up Error: ${error.toString()}')),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        FacebookAuthButton(
                          label: 'Sign up with Facebook',
                          onSuccess: (UserCredential userCredential) {
                            Navigator.of(context).pushReplacementNamed('/HomePage');
                          },
                          onError: (Exception error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Facebook Sign-Up Error: ${error.toString()}')),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        if (Theme.of(context).platform == TargetPlatform.iOS)
                          AppleAuthButton(
                            label: 'Sign up with Apple',
                            onSuccess: (UserCredential userCredential) {
                              // Navigate to the HomePage on successful sign-up
                              Navigator.of(context).pushReplacementNamed('/HomePage');
                            },
                            onError: (Exception error) {
                              // Display a snackbar with the error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Apple Sign-Up Error: ${error.toString()}')),
                              );
                            },
                          ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        const AuthDivider(),
                        const SizedBox(height: 10),
                        CustomInputField(
                          label: 'Email',
                          hintText: 'Enter your email',
                          isPassword: false,
                          onChanged: (value) => setState(() => _email = value),
                          onSubmitted: (value) => _email = value,
                        ),
                        const SizedBox(height: 15.0),
                        CustomInputField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          isPassword: true,
                          onChanged: (value) => setState(() => _password = value),
                          onSubmitted: (value) => _password = value,
                        ),
                        const SizedBox(height: 15.0),
                        GestureDetector(
                          onTap: () {
                            print("RESET PASSWORD clicked");
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Forgot your password?",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: const Color(0xFFE6E6E6),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: AuthButton(
                                label: 'Sign Up',
                                onPressed: _isLoading ? null : _signUpWithEmail,
                                isLoginButton: false,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: defaultPadding,
                              bottom: 4.0,
                            ),
                            child: StepBarWidget(
                              stepNumber: currentStep,
                              totalSteps: ProfileChooserState.maxSteps,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




