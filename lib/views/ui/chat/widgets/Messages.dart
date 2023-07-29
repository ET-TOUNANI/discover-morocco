import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:discover_morocco/views/ui/chat/bloc/chat/chat_bloc.dart';
import 'package:discover_morocco/views/ui/chat/widgets/chatgpt_answer_widget.dart';
import 'package:discover_morocco/views/ui/chat/widgets/user_question_widget.dart';

class Messages extends StatelessWidget {
  Messages({super.key});
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.only(top: 14),
        child: (state.answers.isEmpty)
            ? Center(
                child: Lottie.asset(
                  'assets/mock/bot.json',
                ),
              )
            : ListView.builder(
                controller: _scrollController,
                //reverse: true,
                itemBuilder: (context, index) => Column(
                  children: [
                    UserQuestionWidget(
                      question: state.questions[index],
                    ),
                    ChatGptAnswerWidget(
                      animated: (state.answers[index] == "...") ? true : false,
                      answer: state.answers[index],
                    ),
                  ],
                ),
                itemCount: state.answers.length,
              ),
      );
    });
  }
}
