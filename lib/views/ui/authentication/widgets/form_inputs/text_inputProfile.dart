import 'package:discover_morocco/views/ui/authentication/bloc/bloc.dart';
import 'package:discover_morocco/views/widgets/icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFormInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final bool Function(ProfileState, ProfileState) buildWhen;
  final Key textFieldKey;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String, BuildContext, ProfileState) onChanged;
  final String? Function(BuildContext, ProfileState) getError;

  const TextFormInput({
    super.key,
    required this.label,
    required this.hint,
    required this.buildWhen,
    required this.textFieldKey,
    required this.keyboardType,
    required this.obscureText,
    required this.onChanged,
    required this.getError,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: buildWhen,
      builder: (context, state) {
        final error = getError(context, state);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: IconTextField.sizedIcon(
                textFieldKey: textFieldKey,
                icon: icon,
                hint: hint,
                multiline: false,
                keyboardType: keyboardType,
                obscureText: obscureText,
                backgroundColor: Colors.grey.shade100,
                backgroundFocusColor: theme.primaryColor.withOpacity(0.02),
                deactiveColor: Colors.grey.shade300,
                focusColor: theme.primaryColor.withOpacity(0.5),
                onChanged: (value) => onChanged(value, context, state),
              ),
            ),
            AnimatedCrossFade(
              crossFadeState: error != null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 200),
              firstChild: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 8.0,
                  start: 64.0,
                ),
                child: Text(
                  error ?? '',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
              secondChild: const SizedBox(),
            )
          ],
        );
      },
    );
  }
}
