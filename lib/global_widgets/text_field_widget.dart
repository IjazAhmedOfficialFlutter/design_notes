import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';
import '../utilities/app_text_styles_poppins.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController? textFieldController;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final int maxLines;
  final int? maxCharacters;
  final bool readOnly;
  final bool enabled;
  final VoidCallback? onTap;
  final Color? textFieldColor;
  final TextStyle? textStyle; // Custom text style for input
  final TextStyle? hintTextStyle; // Custom hint text style

  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.textFieldController,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.textFieldColor = Colors.transparent,
    this.validator,
    this.maxCharacters,
    required this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.textStyle, // Added parameter for text style
    this.hintTextStyle, // Added parameter for hint text style
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      maxLength: widget.maxCharacters,
      controller: widget.textFieldController,
      validator: widget.validator,
      enabled: widget.enabled,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      style: widget.textStyle ?? const TextStyle(color: Colors.white), // Apply custom style
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        filled: true,
        fillColor: widget.textFieldColor,
        hintStyle: widget.hintTextStyle ?? fourteen400TextStyle(color: Colors.grey), // Apply custom hint style
        hintText: widget.hintText,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: lightGreenColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: greenColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
