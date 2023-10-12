import 'package:flutter/material.dart';
import 'package:presentation/application/dimen.dart';
import 'package:presentation/application/theme.dart';

class PhotoBrowserTextInput extends StatefulWidget {
  const PhotoBrowserTextInput({
    required this.text,
    required this.onChanged,
    this.isPasswordInput = false,
    this.errorText,
    super.key,
  });

  final String text;
  final Function(String) onChanged;
  final bool isPasswordInput;
  final String? errorText;

  @override
  State<PhotoBrowserTextInput> createState() => _PhotoBrowserTextInputState();
}

class _PhotoBrowserTextInputState extends State<PhotoBrowserTextInput> {
  static const _borderRadius = 30.0;
  static const _errorTextFontSize = 10.0;

  final FocusNode _focus = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    isFocused = _focus.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focus,
      onChanged: widget.onChanged,
      obscureText: widget.isPasswordInput,
      cursorColor: context.palette.primaryColor,
      style: context.textTheme.bodyLarge!.copyWith(color: context.palette.primaryColor),
      decoration: InputDecoration(
        hintText: widget.text,
        hintStyle: context.textTheme.bodyLarge!.copyWith(color: context.palette.primaryColor),
        errorText: isFocused ? widget.errorText : null,
        errorStyle: context.textTheme.labelSmall!.copyWith(
          color: context.palette.errorColor,
          fontSize: _errorTextFontSize,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.palette.primaryColor,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.palette.primaryColor),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.palette.primaryColor),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: Insets.xSmall,
          horizontal: Insets.large,
        ),
      ),
    );
  }
}
