import 'package:flutter/material.dart';

class CubeScreen extends StatefulWidget {
  const CubeScreen({super.key});

  @override
  State<CubeScreen> createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  final List<MainAxisAlignment> alignmentList = [
    MainAxisAlignment.start,
    MainAxisAlignment.center,
    MainAxisAlignment.end,
  ];

  int verticalAlignmentIndex = 1;
  int horizontalAlignmentIndex = 1;

  Widget get _squareFieldBuilder => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: alignmentList[verticalAlignmentIndex],
          children: [
            Row(
              mainAxisAlignment: alignmentList[horizontalAlignmentIndex],
              children: [
                _squareBuilder,
              ],
            ),
          ],
        ),
      );

  Widget get _buttonsBuilder => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: verticalAlignmentIndex > 0
                ? () => setState(() => verticalAlignmentIndex--)
                : null,
            child: const Text('Вверх'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                onPressed: horizontalAlignmentIndex > 0
                    ? () => setState(() => horizontalAlignmentIndex--)
                    : null,
                child: const Text('Влево'),
              ),
              FilledButton(
                onPressed: horizontalAlignmentIndex < 2
                    ? () => setState(() => horizontalAlignmentIndex++)
                    : null,
                child: const Text('Вправо'),
              ),
            ],
          ),
          FilledButton(
            onPressed: verticalAlignmentIndex < 2
                ? () => setState(() => verticalAlignmentIndex++)
                : null,
            child: const Text('Вниз'),
          ),
        ],
      );

  Widget get _squareBuilder => Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cube screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: _squareFieldBuilder,
          ),
          Expanded(
            child: _buttonsBuilder,
          ),
        ],
      ),
    );
  }
}
