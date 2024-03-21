import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
  final Widget child;

  final void Function()? onTap;

  const AppBarActionButton({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
