
import 'package:discover_morocco/views/ui/publication/bloc/publication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:discover_morocco/views/widgets/icon_text_field.dart';

class TextFormInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final bool Function(PublicationState, PublicationState) buildWhen;
  final Key textFieldKey;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String, BuildContext, PublicationState) onChanged;
  final String? Function(BuildContext, PublicationState) getError;
  final bool height;
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
    this.height=false
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<PublicationCubit, PublicationState>(
      buildWhen: buildWhen,
      builder: (context, state) {

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
                multiline:height,
                height: (height)?170:50,
                keyboardType: keyboardType,
                obscureText: obscureText,
                backgroundColor: Colors.grey.shade100,
                backgroundFocusColor: theme.primaryColor.withOpacity(0.02),
                deactiveColor: Colors.grey.shade300,
                focusColor: theme.primaryColor.withOpacity(0.5),
                onChanged: (value) => onChanged(value, context, state),
              ),
            ),
          ],
        );
      },
    );
  }
}
