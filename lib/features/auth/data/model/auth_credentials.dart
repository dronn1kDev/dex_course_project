import 'package:json_annotation/json_annotation.dart';

part 'auth_credentials.g.dart';

@JsonSerializable()
class AuthCredentialsModel {
  final String jvtToken;

  AuthCredentialsModel({
    required this.jvtToken,
  });

  factory AuthCredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialsModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthCredentialsModelToJson(this);
}
