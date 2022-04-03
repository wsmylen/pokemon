import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color primary;
  final double width;
  final double height;
  final Function() onPressed;
  final double? elevation;
  final double? fontSize;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.onPressed,
      required this.primary,
      required this.width,
      required this.height,
      this.elevation,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: ElevatedButton(
        onPressed: onPressed,
        child: SizedBox(
            width: width,
            height: height,
            child: Center(
                child: Text(text,
                    style: TextStyle(
                        fontSize: fontSize,
                        color: textColor,
                        fontWeight: FontWeight.bold)))),
        style: ElevatedButton.styleFrom(
            primary: primary,
            elevation: elevation,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
