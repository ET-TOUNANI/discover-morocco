import 'package:bloc/bloc.dart';
import 'package:discover_morocco/business_logic/models/chat_model.dart';
import 'package:discover_morocco/business_logic/services/Chat_gpt_api.dart';
import 'package:discover_morocco/business_logic/utils/logicConstants.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatGptAPI chatGptAPI = ChatGptAPI();
  ChatBloc() : super(ChatInitial()) {
    on((SendMessageEvent event, emit) async {
      final answers = [...state.answers];
      state.questions.add(event.message);
      answers.add("...");
      emit(ChatLoading(answers: answers, questions: state.questions));
      try {
        ChatModel message = await chatGptAPI.sendMessage(
            message: event.message, modelId: Constant.currentModel);
        answers.removeLast();
        answers.add(message.choices!.first.message!.content ?? '');
        emit(ChatSuccess(answers: answers, questions: state.questions));
      } catch (e) {
        answers.removeLast();
        answers.add(
            "We are currently facing a technical issue. Please try again after sometime.");
        emit(ChatError(answers: answers, questions: state.questions));
      }
    });
  }
}
