import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:discover_morocco/views/utils/Themes.dart';

class ChatGptAnswerWidget extends StatelessWidget {
  final String answer;
  final bool animated;
  const ChatGptAnswerWidget(
      {required this.answer, Key? key, required this.animated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -10,
          child: ClipOval(
            child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset("assets/mock/bot.png")),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding:  const EdgeInsets.only(
                    left: 15, top: 2, right: 28, bottom: 6),
                child: Container(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  margin: const EdgeInsets.only(left: 30, top: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color: Themes().lightBrightness.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: (!animated)
                      ? Text(
                          answer.toString().trim(),
                          style: Themes.kBlackText.copyWith(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        )
                      : Lottie.asset('assets/mock/typing.json',
                          height: 25, width: 60),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
