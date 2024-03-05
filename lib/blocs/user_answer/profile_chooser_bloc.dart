import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ifitchallenge/blocs/user_answer/user_answer_event.dart';
import 'user_answer_bloc.dart'; // Import your UserAnswerBloc

// ProfileChooserEvent
abstract class ProfileChooserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepChanged extends ProfileChooserEvent {
  final int step;

  StepChanged(this.step);

  @override
  List<Object?> get props => [step];
}

class AnswerSaved extends ProfileChooserEvent {
  final Map<int, String> answers;

  AnswerSaved(this.answers);

  @override
  List<Object?> get props => [answers];
}

// ProfileChooserState
abstract class ProfileChooserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileChooserInitial extends ProfileChooserState {}

class ProfileChooserStepChanged extends ProfileChooserState {
  final int step;

  ProfileChooserStepChanged(this.step);

  @override
  List<Object?> get props => [step];
}

// ProfileChooserBloc
class ProfileChooserBloc extends Bloc<ProfileChooserEvent, ProfileChooserState> {
  final UserAnswerBloc userAnswerBloc;

  ProfileChooserBloc({required this.userAnswerBloc}) : super(ProfileChooserInitial()) {
    on<StepChanged>((event, emit) => emit(ProfileChooserStepChanged(event.step)));
    on<AnswerSaved>(_onAnswerSaved);
  }

  void _onAnswerSaved(AnswerSaved event, Emitter<ProfileChooserState> emit) {
    // Dispatch SaveAnswers to UserAnswerBloc
    userAnswerBloc.add(SaveAnswers(event.answers));
    // Optionally, emit a state to indicate that the answers have been saved

  }
}
