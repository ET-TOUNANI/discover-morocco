import 'package:flutter/material.dart';
import 'package:discover_morocco/views/utils/Themes.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSubmitted;

  const TextInputWidget(
      {required this.textController, required this.onSubmitted, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, left: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: textController,
              minLines: 1,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              style: Themes.kBlackText.copyWith(fontSize: 16),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Type in...',
                hintStyle: Themes.kBlackText.copyWith(fontSize: 16),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 12.0),
              ),
              onFieldSubmitted: (_) => onSubmitted,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (textController.text.isNotEmpty) {
                return onSubmitted();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                      child: Text(
                    "Please type a message",
                    style: Themes.kBlackText.copyWith(fontSize: 18),
                  )),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
/*

 */
