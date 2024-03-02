import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(35),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<MainAxisAlignment> alignment = [
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
          mainAxisAlignment: alignment[verticalAlignmentIndex],
          children: [
            Row(
              mainAxisAlignment: alignment[horizontalAlignmentIndex],
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
                ? () => setState(() {
                      verticalAlignmentIndex--;
                    })
                : null,
            child: const Text('Вверх'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                onPressed: horizontalAlignmentIndex > 0
                    ? () => setState(() {
                          horizontalAlignmentIndex--;
                        })
                    : null,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(35),
                ),
                child: const Text('Влево'),
              ),
              FilledButton(
                onPressed: horizontalAlignmentIndex < 2
                    ? () => setState(() {
                          horizontalAlignmentIndex++;
                        })
                    : null,
                child: const Text('Вправо'),
              ),
            ],
          ),
          FilledButton(
            onPressed: verticalAlignmentIndex < 2
                ? () => setState(() {
                      verticalAlignmentIndex++;
                    })
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
        title: Text(widget.title),
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
