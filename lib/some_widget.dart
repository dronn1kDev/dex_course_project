import 'package:flutter/material.dart';

class SomeWidget extends StatelessWidget {
  final String text;

  const SomeWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    // home work #3
    return Container(
      color: Colors.greenAccent[200],
      child: Text(
        text,
        style: const TextStyle(fontSize: 32),
      ),
    );
  }
}
