// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataRemoteResponse<T> _$DataRemoteResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    DataRemoteResponse<T>(
      data: fromJsonT(json['result']),
    );

ErrorRemoteResponse<T> _$ErrorRemoteResponseFromJson<T>(
        Map<String, dynamic> json) =>
    ErrorRemoteResponse<T>(
      title: json['title'] as String,
      detail: json['detail'] as String,
      errorList: ErrorRemoteResponse._errorsMapper(
          json['errorList'] as Map<String, List<Map<String, dynamic>>>),
    );
