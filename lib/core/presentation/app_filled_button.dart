import 'dart:async';

import 'package:flutter/material.dart';

class AppFilledButton extends StatefulWidget {
  final FutureOr<void> Function()? onPressed;

  final Widget? child;

  final double? width;

  const AppFilledButton({
    super.key,
    this.onPressed,
    this.child,
    this.width,
  });

  @override
  State<AppFilledButton> createState() => _AppFilledButtonState();
}

class _AppFilledButtonState extends State<AppFilledButton> {
  bool _isLoading = false;

  final _buttonGlobalKey = GlobalKey();

  double? _buttonHeight;

  Future<void> _onPressed() async {
    if (_isLoading) return;
    try {
      setState(() => _isLoading = true);

      await widget.onPressed?.call();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _buttonHeight = _buttonGlobalKey.currentContext?.size?.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _buttonGlobalKey,
      width: widget.width ?? double.maxFinite,
      height: _buttonHeight,
      child: FilledButton(
        onPressed: widget.onPressed != null ? _onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: !_isLoading
            ? widget.child
            : const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
