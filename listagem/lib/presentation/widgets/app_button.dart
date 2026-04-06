import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isSecondary;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isSecondary = false,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget button;

    if (icon != null) {
      if (isSecondary) {
        button = OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(text),
        );
      } else {
        button = FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(text),
        );
      }
    } else {
      if (isSecondary) {
        button = OutlinedButton(
          onPressed: onPressed,
          child: Text(text),
        );
      } else {
        button = FilledButton(
          onPressed: onPressed,
          child: Text(text),
        );
      }
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}
