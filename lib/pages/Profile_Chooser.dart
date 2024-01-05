import 'package:flutter/material.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';
import 'package:provider/provider.dart';
import '../widgets/buttons/back_button.dart';
import '../widgets/buttons/paso_cinco_buttons.dart';
import '../widgets/buttons/paso_cuatro_buttons.dart';
import '../widgets/buttons/paso_dos_buttons.dart';
import '../widgets/buttons/paso_tres_buttons.dart';
import '../widgets/buttons/paso_uno_buttons.dart';
import '../widgets/buttons/next_button.dart';
import '../widgets/profile_titles.dart';
import '../widgets/stepBarWidget.dart';
import 'Auth/SignUpPage.dart';

class ProfileChooser extends StatefulWidget {
  const ProfileChooser({super.key});
  @override
  _ProfileChooserState createState() => _ProfileChooserState();
}
class _ProfileChooserState extends State<ProfileChooser> {
  late Future<void> _imageLoading;
  @override
  void initState() {
    super.initState();
    _imageLoading = _preloadImages();
  }
  Future<void> _preloadImages() async {
    // Precache background images
    for (int step = 1; step <= 5; step++) {
      await precacheImage(
        AssetImage('assets/images/background_step$step.png'),
        context,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // Define background image assets for each case
    Map<int, String> backgroundAssets = {
      1: 'background_signin1.png',
      2: 'background_signin2.png',
      3: 'background_signin2.png',
      4: 'background_signin3.png',
      5: 'background_signin4.png',
    };
    return ChangeNotifierProvider(
      create: (context) => ProfileChooserState(),
      child: Consumer<ProfileChooserState>(
        builder: (context, state, child) {
          return FutureBuilder(
            future: _imageLoading,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SafeArea(
                  child: Scaffold(
                    body: Stack(
                      fit: StackFit.expand,
                      children: [
                        _buildBackground(state.currentStep, backgroundAssets),
                        if (state.currentStep == 6) ...[
                          SignUpPage(profileChooserState: state),
                        ] else ...[
                          Positioned(
                            bottom: 16.0,
                            left: 16.0,
                            child: StepBarWidget(
                                stepNumber: state.currentStep,
                                totalSteps: ProfileChooserState.maxSteps),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    BackxButton(
                                      onBackPressed: () {
                                        if (state.currentStep >
                                            ProfileChooserState.minStep) {
                                          state.onStepSelected(
                                              state.currentStep - 1);
                                        } else {
                                          context.navigateTo('/ChooseOption');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Center(
                                    child: ProfileTextWidget(
                                        caseNumber: state.currentStep),
                                  ),
                                ),
                                const SizedBox(height: 70),
                                _buildTransitionWidget(state),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildTransitionWidget(ProfileChooserState state) {
    Widget transitionWidget = const SizedBox(); // Default value
    if (state.currentStep == 1) {
      transitionWidget = ButtonWidgetStep1(
        currentStep: state.currentStep,
        onStepSelected: state.onStepSelected,
      );
    } else if (state.currentStep == 2) {
      transitionWidget = Column(
        children: [
          GenderSelectionWidget(
            currentStep: state.currentStep,
            onStepSelected: state.onStepSelected,
          ),
          const SizedBox(height: 80),
          NextButton(
            onPressed: () {
              state.onStepSelected(state.currentStep + 1);
            },
            label: "NEXT",
          ),
        ],
      );
    } else if (state.currentStep == 3) {
      transitionWidget = ButtonWidgetStep3(
        currentStep: state.currentStep,
        onStepSelected: state.onStepSelected,
      );
    } else if (state.currentStep == 4) {
      transitionWidget = ButtonWidgetStep4(
        currentStep: state.currentStep,
        onStepSelected: state.onStepSelected,
      );
    } else if (state.currentStep == 5) {
      transitionWidget = ButtonWidgetStep5(
        currentStep: state.currentStep,
        onStepSelected: state.onStepSelected,
      );
    }
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.5,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeInOut,
        ),
      ),
      child: transitionWidget,
    );
  }

  Widget _buildBackground(int currentStep, Map<int, String> backgroundAssets) {
    if (currentStep == 2) {
      // Linear gradient for case 2
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF252525),
        ),
      );
    } else {
      // Image background for other cases
      return Opacity(
        opacity: 0.95,
        child: Image.asset(
          'assets/images/${backgroundAssets[currentStep]}',
          fit: BoxFit.cover,
        ),
      );
    }
  }
}

class ProfileChooserState extends ChangeNotifier {
  static const int maxSteps = 6;
  static const int minStep = 1;
  late int _currentStep;
  Map<int, dynamic> userAnswers = {};
  int get currentStep => _currentStep;

  ProfileChooserState() {
    _currentStep = minStep;
  }
  void onStepSelected(int step) {
    userAnswers[_currentStep] = 'User answer for step $_currentStep';
    if (step >= minStep && step <= maxSteps) {
      _currentStep = step;
    }
    notifyListeners();
  }
}


