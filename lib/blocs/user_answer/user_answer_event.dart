import 'package:equatable/equatable.dart';

abstract class UserAnswerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveAnswers extends UserAnswerEvent {
  final Map<int, String> answers;

  SaveAnswers(this.answers);

  @override
  List<Object> get props => [answers];
}

class ClearAnswers extends UserAnswerEvent {}
