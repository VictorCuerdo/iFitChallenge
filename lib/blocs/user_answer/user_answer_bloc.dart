import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_answer_event.dart';
import 'user_answer_state.dart';

class UserAnswerBloc extends Bloc<UserAnswerEvent, UserAnswerState> {
  UserAnswerBloc() : super(AnswersInitial()) {
    on<SaveAnswers>(_onSaveAnswers);
    on<ClearAnswers>(_onClearAnswers);
  }

  void _onSaveAnswers(SaveAnswers event, Emitter<UserAnswerState> emit) {
    try {
      emit(AnswersLoading());
      // Logic to save the answers, e.g., in a database or state
      // For now, we'll just emit the saved state with the answers
      emit(AnswersSaved(event.answers));
    } catch (e) {
      emit(AnswersError(e.toString()));
    }
  }

  void _onClearAnswers(ClearAnswers event, Emitter<UserAnswerState> emit) {
    // Clear the stored answers
    emit(AnswersInitial());
  }
}
