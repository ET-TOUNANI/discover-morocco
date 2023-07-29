import 'package:flutter/material.dart';
import 'package:discover_morocco/views/utils/Themes.dart';

class UserQuestionWidget extends StatelessWidget {
  final String question;

  const UserQuestionWidget({required this.question, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          Positioned(
            bottom: 5,
            right: 0,
            child: ClipOval(
              child: SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/mock/profile.png")),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 2, right: 28, bottom: 6),
                  child: Container(
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Themes.backgroundChatAnswer,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      question,
                      style: Themes.kBlackText.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
