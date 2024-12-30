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

  const TextFieldWidget(
      {super.key,
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
      this.onTap});

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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(

        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        filled: true,
        fillColor: widget.textFieldColor,
        hintStyle: fourteen400TextStyle(color: Colors.white),
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
