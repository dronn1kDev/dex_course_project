import 'package:dex_course_temp/core/domain/app_error/app_error.dart';
import 'package:dex_course_temp/features/advertisement/domain/entity/advertisement_list_item.dart';

sealed class AdvListState {}

class LoadingAdvListState implements AdvListState {}

class DataAdvListState implements AdvListState {
  final List<AdvertisementListItem> data;
  DataAdvListState({
    required this.data,
  });
}

class ErrorAdvListState implements AdvListState {
  List<AppError> errorList;
  ErrorAdvListState({
    required this.errorList,
  });
}
