import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:ifitchallenge/pages/Auth/SignUpPage.dart';
import 'package:ifitchallenge/pages/Choose_Option.dart';
import 'package:ifitchallenge/pages/Home_Page.dart';
import 'package:ifitchallenge/pages/Profile_Chooser.dart';
import 'package:ifitchallenge/pages/Loading_Screen.dart';
import 'package:ifitchallenge/pages/Auth/SignInPage.dart';
import 'package:ifitchallenge/firebase_options.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/user_answer/user_answer_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            facebookAuth: FacebookAuth.instance,
          ),
        ),
        BlocProvider<UserAnswerBloc>(
          create: (context) => UserAnswerBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'IFitChallenge',
        home: const LoadingScreen(),
        routes: {
          '/SignIn': (context) => const SignInPage(),
          '/HomePage': (context) => HomePage(),
          '/ChooseOption': (context) => const ChooseOption(),
          '/ProfileChooser': (context) => const ProfileChooser(),
          '/LoadingScreen': (context) => const LoadingScreen(),
        },
      ),
    );
  }
}

