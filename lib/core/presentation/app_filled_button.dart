import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final void Function()? onPressed;

  final Widget? child;

  const AppFilledButton({
    super.key,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: child,
    );
  }
}
