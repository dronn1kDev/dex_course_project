import 'package:dex_course_temp/bloc/cube_position_bloc.dart';
import 'package:dex_course_temp/theme/svg_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CubeScreen extends StatefulWidget {
  const CubeScreen({super.key});

  @override
  State<CubeScreen> createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  late final CubePositionBloc cubit = context.read<CubePositionBloc>();

  Widget get _squareFieldBuilder => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        child: BlocBuilder<CubePositionBloc, CubePositionState>(
          builder: (context, state) => Column(
            mainAxisAlignment: cubit.currentVerticalAlignment,
            children: [
              Row(
                mainAxisAlignment: cubit.currentHorizontalAlignment,
                children: [
                  _squareBuilder,
                ],
              ),
            ],
          ),
        ),
      );

  Widget get _buttonsBuilder => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: cubit.isPossibleToMoveTop ? cubit.moveTop : null,
            child: const Text('Вверх'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const FilledButton(
                onPressed: null,
                child: Text('Влево'),
              ),
              FilledButton(
                onPressed: null,
                child: Row(
                  children: [
                    SvgPicture.asset(SvgCollection.phoneNumber),
                    // const Icon(Icons.call_outlined),
                    const Text('Вправо'),
                  ],
                ),
              ),
            ],
          ),
          FilledButton(
            onPressed: cubit.isPossibleToMoveBottom ? cubit.moveBottom : null,
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
            child: BlocProvider(
              create: (context) => CubePositionBloc(),
              child: _squareFieldBuilder,
            ),
          ),
          Expanded(
            child: _buttonsBuilder,
          ),
        ],
      ),
    );
  }
}
