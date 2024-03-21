import 'package:dex_course_temp/core/domain/app_error/app_error.dart';

sealed class UseCaseResult<T> {
  bool get isSuccess;

  factory UseCaseResult({
    T? data,
    List<AppError>? errorList,
  }) {
    assert(((data == null) ^ (errorList == null)),
        'Data & error list can not be the same filled!');
    if (data != null) {
      return UseCaseResult.good(data);
    }
    if (errorList != null) {
      return UseCaseResult.bad(errorList);
    }
    throw Exception('Something went wrong with UseCaseResult arguments!');
  }

  const factory UseCaseResult.good(T data) = GoodUseCaseResult;

  const factory UseCaseResult.bad(List<AppError> errorList) = BadUseCaseResult;
}

class GoodUseCaseResult<T> implements UseCaseResult<T> {
  final T data;

  const GoodUseCaseResult(this.data);

  @override
  bool get isSuccess => true;
}

class BadUseCaseResult<T> implements UseCaseResult<T> {
  final List<AppError> errorList;

  const BadUseCaseResult(this.errorList);

  @override
  bool get isSuccess => false;
}
