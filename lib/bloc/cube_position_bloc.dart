import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CubePositionState {
  final int verticalAlignmentIndex;
  final int horizontalAlignmentIndex;

  CubePositionState({
    required this.verticalAlignmentIndex,
    required this.horizontalAlignmentIndex,
  });
}

class CubePositionBloc extends Cubit<CubePositionState> {
  final List<MainAxisAlignment> alignmentList = [
    MainAxisAlignment.start,
    MainAxisAlignment.center,
    MainAxisAlignment.end,
  ];

  CubePositionBloc()
      : super(CubePositionState(
          horizontalAlignmentIndex: 1,
          verticalAlignmentIndex: 1,
        ));

  MainAxisAlignment get currentVerticalAlignment =>
      alignmentList[state.verticalAlignmentIndex];
  MainAxisAlignment get currentHorizontalAlignment =>
      alignmentList[state.horizontalAlignmentIndex];

  bool get isPossibleToMoveTop => state.verticalAlignmentIndex > 0;
  bool get isPossibleToMoveBottom => state.verticalAlignmentIndex < 2;

  void moveTop() => emit(CubePositionState(
        horizontalAlignmentIndex: state.horizontalAlignmentIndex,
        verticalAlignmentIndex: state.verticalAlignmentIndex - 1,
      ));

  void moveBottom() => emit(CubePositionState(
        horizontalAlignmentIndex: state.horizontalAlignmentIndex,
        verticalAlignmentIndex: state.verticalAlignmentIndex + 1,
      ));
}
