import 'package:equatable/equatable.dart';

abstract class UserAnswerState extends Equatable {
  @override
  List<Object> get props => [];
}

class AnswersInitial extends UserAnswerState {}

class AnswersLoading extends UserAnswerState {}

class AnswersSaved extends UserAnswerState {
  final Map<int, String> answers;

  AnswersSaved(this.answers);

  @override
  List<Object> get props => [answers];
}

class AnswersError extends UserAnswerState {
  final String message;

  AnswersError(this.message);

  @override
  List<Object> get props => [message];
}
