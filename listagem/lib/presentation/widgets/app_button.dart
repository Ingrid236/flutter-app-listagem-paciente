import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isSecondary;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      if (isSecondary) {
        return OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(text),
        );
      }
      return FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
      );
    }

    if (isSecondary) {
      return OutlinedButton(
        onPressed: onPressed,
        child: Text(text),
      );
    }
    return FilledButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
