import 'package:dex_course_temp/core/data/model/rest_api_error_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_response.g.dart';

typedef JsonType = Map<String, dynamic>;
typedef TypeFromJson<T> = T Function(Object?);

const _dataJsonKey = 'result';

sealed class RemoteResponse<T> {
  factory RemoteResponse.fromJson(JsonType json, TypeFromJson<T> fromJsonT) {
    if (json.containsKey('title') &&
        json.containsKey('detail') &&
        json.containsKey('errors')) {
      return ErrorRemoteResponse.fromJson(json);
    }
    final stringType = T.toString();
    if (stringType == 'void') {
      return VoidRemoteResponse<T>();
    } else if (json[_dataJsonKey] != null) {
      return DataRemoteResponse.fromJson(json, fromJsonT);
    } else {
      throw UnimplementedError();
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  createToJson: false,
  genericArgumentFactories: true,
)
class DataRemoteResponse<T> implements RemoteResponse<T> {
  @JsonKey(name: _dataJsonKey)
  final T data;

  DataRemoteResponse({
    required this.data,
  });

  factory DataRemoteResponse.fromJson(
          JsonType json, TypeFromJson<T> typeFromJson) =>
      _$DataRemoteResponseFromJson(json, typeFromJson);
}

class VoidRemoteResponse<T> implements RemoteResponse<T> {
  const VoidRemoteResponse();
}

@JsonSerializable(createToJson: false)
class ErrorRemoteResponse<T> implements RemoteResponse<T> {
  final String title;
  final String detail;
  @JsonKey(fromJson: _errorsMapper)
  final List<RestApiValidationErrorModel> errorList;

  static List<RestApiValidationErrorModel> _errorsMapper(
      Map<String, List<Map<String, dynamic>>> errorMap) {
    final resultList = <RestApiValidationErrorModel>[];
    for (final MapEntry(:key, :value) in errorMap.entries) {
      List<RestApiErrorDetails> errorList = [];
      for (final element in value) {
        errorList.add((code: element['errorCode'], params: element['params']));
      }
      resultList.add(
          RestApiValidationErrorModel(fieldName: key, errorList: errorList));
    }
    return resultList;
  }

  const ErrorRemoteResponse({
    required this.title,
    required this.detail,
    required this.errorList,
  });

  factory ErrorRemoteResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorRemoteResponseFromJson(json);
}
