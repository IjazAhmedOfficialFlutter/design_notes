// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BigButton extends StatefulWidget {
  final double width;
  final double height;
  final Color containerColor;
  final Color? borderColor;
  final double? borderRadius;
  final String text;
  final VoidCallback onTap;
  final TextStyle textStyle;
  const BigButton(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.onTap,
      required this.textStyle,
      required this.containerColor,
      this.borderColor = Colors.transparent,
      this.borderRadius = 10.0});

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.containerColor,
          border: Border.all(
            color: widget.borderColor!,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}
