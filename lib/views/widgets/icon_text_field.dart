import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconTextField extends StatefulWidget {
  final Key? textFieldKey;
  final AsyncCallback? iconCallback;
  final Widget icon;
  final String? hint;
  final String? errorText;

  final double dividerIntent;
  final double height;
  final bool multiline;

  final bool obscureText;
  final Color? backgroundColor;
  final Color? backgroundFocusColor;
  final Color deactiveColor;
  final Color focusColor;
  final String initialValue;

  final TextInputType? keyboardType;

  final void Function(String)? onChanged;

  const IconTextField({
    super.key,
    required this.icon,
    required this.deactiveColor,
    required this.focusColor,
    this.errorText,
    this.onChanged,
    required this.multiline,
    this.textFieldKey,
    this.keyboardType,
    this.backgroundColor,
    this.backgroundFocusColor,
    this.obscureText = false,
    this.iconCallback,
    this.height = 50,
    this.dividerIntent = 0,
    this.hint, required this.initialValue,
  });

  IconTextField.sizedIcon({
    super.key,
    required IconData icon,
    required this.deactiveColor,
    required this.focusColor,
    this.errorText,
    this.onChanged,
    this.textFieldKey,
    this.keyboardType,
    this.backgroundColor,
    this.backgroundFocusColor,
    this.obscureText = false,
    this.iconCallback,
    this.height = 50,
    this.dividerIntent = 0,
    this.hint,
    required this.multiline, required this.initialValue,
  }) : icon = SizedBox(
          height: height,
          width: 60,
          child: Icon(
            icon,
            color: Colors.grey.shade600,
          ),
        );

  @override
  State<IconTextField> createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  final FocusNode focusNode = FocusNode();

  bool hasFocus = false;

  @override
  void initState() {
    focusNode.addListener(onfocusChanged);
    super.initState();
  }

  void onfocusChanged() {
    setState(() {
      hasFocus = focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(
          color: hasFocus ? widget.focusColor : widget.deactiveColor,
        ),
        borderRadius: BorderRadius.circular(32),
        color: hasFocus
            ? widget.backgroundFocusColor ?? widget.backgroundColor
            : widget.backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: widget.iconCallback,
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(32),
              bottomStart: Radius.circular(32),
            ).resolve(Directionality.of(context)),
            child: IconTheme.merge(
                data: IconThemeData(
                  color: hasFocus ? widget.focusColor : null,
                ),
                child: widget.icon),
          ),
          VerticalDivider(
            color: hasFocus ? widget.focusColor : widget.deactiveColor,
            thickness: 0.5,
            width: 0,
            indent: widget.dividerIntent,
            endIndent: widget.dividerIntent,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: (widget.multiline) ? 10 : 0),
              child: TextFormField(
                focusNode: focusNode,
                obscureText: widget.obscureText,
                initialValue: widget.initialValue,
                keyboardType: (widget.multiline)
                    ? TextInputType.multiline
                    : widget.keyboardType,
                onChanged: widget.onChanged,
                minLines: 1,
                maxLines: (widget.multiline) ? 10 : 1,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  alignLabelWithHint: true,
                  errorText: widget.errorText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
