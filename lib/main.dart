import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifitchallenge/pages/Auth/SignUpPage.dart';
import 'package:ifitchallenge/pages/Choose_Option.dart';
import 'package:ifitchallenge/pages/Home_Page.dart';
import 'package:ifitchallenge/pages/Profile_Chooser.dart';

import '../pages/Loading_Screen.dart';
import 'pages/Auth/SignInPage.dart';

import '../pages/Choose_Option.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const IFitChallengeApp());
}

class IFitChallengeApp extends StatelessWidget {
  const IFitChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'IFitChallenge',
      home: const LoadingScreen(),

      routes: {
        '/SignIn': (context) => const SignInPage(),
        '/HomePage': (context) => HomePage(),
        '/ChooseOption' : (context)  => const ChooseOption(),
        '/ProfileChooser': (context)  => const ProfileChooser(),
        '/LoadingScreen': (context) => const LoadingScreen(),
      },

    );
  }
}

