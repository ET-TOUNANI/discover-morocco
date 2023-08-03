import 'package:discover_morocco/views/ui/chat/bloc/chat/chat_bloc.dart';
import 'package:discover_morocco/views/ui/chat/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonNavigationBar extends StatelessWidget {
  ButtonNavigationBar({super.key});
  final TextEditingController inputText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
        textController: inputText,
        onSubmitted: () {
          sendTextMessage(context, inputText.text);
        });
  }

  void sendTextMessage(BuildContext context, String message) {
    context.read<ChatBloc>().add(SendMessageEvent(message: message));
    inputText.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
