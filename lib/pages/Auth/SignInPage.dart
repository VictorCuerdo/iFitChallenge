import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_divider.dart';
import '../../widgets/auth/input_fields.dart';
import '../../widgets/auth/social_media_buttons/apple_auth_button.dart';
import '../../widgets/auth/social_media_buttons/facebook_auth_button.dart';
import '../../widgets/auth/social_media_buttons/google_auth_button.dart';
import '../../widgets/buttons/back_button.dart';
import '../../widgets/buttons/close_button.dart';
import '../Home_Page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';
  bool _isLoading = false;
  bool obscureText = true;

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
    BackxButton(onBackPressed: () {
    context.navigateTo('/ChooseOption');
    }),
    ],
    ),
    const SizedBox(height: 20.0),

      Padding(
        padding: EdgeInsets.only(left: defaultPadding),
        child: const Row(
          children: [
            Text(
              "Log in to your account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Open Sans',
              ),
            ),
            SizedBox(width: 8.0), // Adjust the spacing between text and icon as needed
            Icon(
              Icons.sports_martial_arts,
              color: Colors.orangeAccent,
              size: 32.0,
            ),
          ],
        ),
      ),


      const SizedBox(height: 8.0),

              Padding(
                padding: EdgeInsets.only(left: defaultPadding), // Adjusted left padding
                child: const Text(
                  "Welcome back! Log in fast and smooth!",
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
                        label: 'Log in with Google',
                        onPressed: () {
                          // Handle Google authentication logic here
                        },
                      ),
                      const SizedBox(height: 10),
                      FacebookAuthButton(
                        label: 'Log in with Facebook',
                        onPressed: () {
                          // Handle Facebook authentication logic here
                        },
                      ),
                      const SizedBox(height: 10),
                      if (Theme.of(context).platform == TargetPlatform.iOS)
                        AppleAuthButton(
                          label: 'Log in with Apple',
                          onPressed: () {
                            // Handle Apple authentication logic here
                          },
                        ),
                      const SizedBox(height: 10),
                      const AuthDivider(),
                      const SizedBox(height: 10),
                      CustomInputField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        isPassword: false,
                        onChanged: (value) {
                          // Handle email changes
                        },
                        onSubmitted: (value) {
                          // Handle email submission
                        },
                      ),
                      const SizedBox(height: 15.0),
                      CustomInputField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        isPassword: true,
                        onChanged: (value) {
                          // Handle password changes
                        },
                        onSubmitted: (value) {
                          // Handle password submission
                        },
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
                      const Row(
                        children: [
                          Expanded(
                            child: AuthButton(
                              label: 'Log In',
                              onPressed: null,
                              isLoginButton: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          const AutoSizeText(
                            'By registering to iFitChallenge, you accept our',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFA2A2A4),
                              fontSize: 16,
                              fontFamily: 'Open Sans',
                            ),
                            maxLines: 1,
                            minFontSize: 11,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Terms',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle the Terms link tap
                                      // You can navigate to the Terms page or open a website
                                    },
                                ),
                                const TextSpan(
                                  text: ' and ',
                                  style: TextStyle(
                                    color: Color(0xFFA2A2A4),
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy policy',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle the Privacy policy link tap
                                      // You can navigate to the Privacy policy page or open a website
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
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



