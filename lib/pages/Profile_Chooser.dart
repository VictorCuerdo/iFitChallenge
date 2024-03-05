import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifitchallenge/controllers/navigation_utils.dart';
import '../blocs/profile_chooser/profile_chooser_bloc.dart';
import '../blocs/user_answer/profile_chooser_bloc.dart';
import '../widgets/buttons/back_button.dart';
import '../widgets/buttons/paso_cinco_buttons.dart';
import '../widgets/buttons/paso_cuatro_buttons.dart';
import '../widgets/buttons/paso_dos_buttons.dart';
import '../widgets/buttons/paso_tres_buttons.dart';
import '../widgets/buttons/paso_uno_buttons.dart';
import '../widgets/profile_titles.dart';
import '../widgets/stepBarWidget.dart';
import 'Auth/SignUpPage.dart';

class ProfileChooser extends StatefulWidget {
  const ProfileChooser({Key? key}) : super(key: key);

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
    for (int step = 1; step <= 5; step++) {
      await precacheImage(
        AssetImage('assets/images/background_step$step.png'),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileChooserBloc, ProfileChooserState>(
          builder: (context, state) {
            return FutureBuilder(
              future: _imageLoading,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildBackground(state),
                      if (state is ProfileChooserStepChanged && state.step == 6)
                        SignUpPage(profileChooserState: state), // Assuming 'state' is the required object
                      if (state is ProfileChooserStepChanged && state.step < 6)
                        _buildStepContent(context, state.step),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackground(ProfileChooserState state) {
    Map<int, String> backgroundAssets = {
      1: 'background_signin1.png',
      2: 'background_signin2.png',
      3: 'background_signin2.png',
      4: 'background_signin3.png',
      5: 'background_signin4.png',
    };

    if (state is ProfileChooserStepChanged) {
      return Opacity(
        opacity: 0.95,
        child: Image.asset(
          'assets/images/${backgroundAssets[state.step]}',
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(); // Default background for initial state
    }
  }

  Widget _buildStepContent(BuildContext context, int currentStep) {
    switch (currentStep) {
      case 1:
        return ButtonWidgetStep1(
          currentStep: currentStep,
          onStepSelected: (nextStep, answer) => _onStepSelected(context, nextStep, answer),
        );
      case 2:
        return GenderSelectionWidget(
          currentStep: currentStep,
          onStepSelected: (nextStep, answer) => _onStepSelected(context, nextStep, answer),
        );
      case 3:
        return ButtonWidgetStep3(
          currentStep: currentStep,
          onStepSelected: (nextStep, answer) => _onStepSelected(context, nextStep, answer),
        );
      case 4:
        return ButtonWidgetStep4(
          currentStep: currentStep,
          state: state, // Passing the 'state' parameter
          onStepSelected: (nextStep, answer) => _onStepSelected(context, nextStep, answer),
        );
      case 5:
        return ButtonWidgetStep5(
         
          currentStep: currentStep,
          onStepSelected: (nextStep, answer) => _onStepSelected(context, nextStep, answer),
          state: state(),
        );
      default:
        return Container(); // Default content for unhandled steps
    }
  }

  void _onStepSelected(BuildContext context, int nextStep, String answer) {
    BlocProvider.of<ProfileChooserBloc>(context).add(StepChanged(nextStep, answer));
  }
}



