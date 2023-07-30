import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomShapeContentWidget extends StatelessWidget {
  const CustomShapeContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
        left: 16,
        right: 16,
        bottom: 64,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'assets/images/logo_black.svg',
                  height: 75,
                  semanticsLabel: 'Discover Morocco',
                ),
             const SizedBox(width: 20,),
              Text("Discover \nMorocco", style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 21,
                color: Colors.black,
              ),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              "Open new doors for the next generation of traveler to truly experience the world", //localizations.slogan,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
