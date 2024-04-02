import 'dart:async';

import 'package:dex_course_temp/core/domain/app_error/app_error.dart';
import 'package:dex_course_temp/core/domain/use_case_result/use_case_result.dart';
import 'package:dex_course_temp/features/advertisement/domain/entity/advertisement_list_item.dart';
import 'package:dex_course_temp/features/advertisement/presentation/widget/adv_list_builder/adv_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvListController extends Cubit<AdvListState> {
  AdvListController(super.initialState);

  void _parseUseCaseResult(
    UseCaseResult<List<AdvertisementListItem>> result, [
    List<AdvertisementListItem> oldList = const [],
  ]) {
    switch (result) {
      case GoodUseCaseResult<List<AdvertisementListItem>>(data: final newList):
        final mergedData = [...oldList, ...newList];
        emit(DataAdvListState(data: mergedData));
        break;
      case BadUseCaseResult<List<AdvertisementListItem>>(:final errorList):
        emit(ErrorAdvListState(errorList: errorList));
        break;
    }
  }

  Future<void> append(
      FutureOr<UseCaseResult<List<AdvertisementListItem>>> Function()
          newDataCallback) async {
    switch (state) {
      case ErrorAdvListState():
      case LoadingAdvListState():
        emit(LoadingAdvListState());
        final result = await newDataCallback();
        _parseUseCaseResult(result);
        break;
      case DataAdvListState(:final data):
        final oldData = data;
        emit(LoadingAdvListState());
        final newListResult = await newDataCallback();
        _parseUseCaseResult(newListResult, oldData);
        break;
    }
  }

  Future<void> replace(
      FutureOr<UseCaseResult<List<AdvertisementListItem>>> Function()
          newDataCallback) async {
    final result = await newDataCallback();
    _parseUseCaseResult(result);
  }

  void showErrors(List<AppError> errorList) {
    emit(ErrorAdvListState(errorList: errorList));
  }

  void showLoading() {
    emit(LoadingAdvListState());
  }
}
