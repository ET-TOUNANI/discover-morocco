part of 'chat_bloc.dart';

@immutable
abstract class ChatState {
  final List<String> answers;
  final List<String> questions;
  const ChatState({
    required this.answers,
    required this.questions,
  });
}

class ChatInitial extends ChatState {
  ChatInitial() : super(answers: [], questions: []);
}

class ChatLoading extends ChatState {
  const ChatLoading({required answers, required questions})
      : super(answers: answers, questions: questions);
}

class ChatSuccess extends ChatState {
  const ChatSuccess({required answers, required questions})
      : super(answers: answers, questions: questions);
}

class ChatError extends ChatState {
  const ChatError({required answers, required questions})
      : super(answers: answers, questions: questions);
}
